INSERT INTO hotel_bookings (
    id,
    org_id,
    hotel_id,
    city,
    checkin_date,
    checkout_date,
    amount,
    status,
    created_at
)
SELECT
    gen_random_uuid(),
    md5('organization-' || ((n % 8) + 1))::uuid,
    'hotel-' || lpad((n % 25 + 1)::text, 3, '0'),
    (ARRAY['delhi', 'mumbai', 'bengaluru', 'chennai', 'pune'])[n % 5 + 1],
    CURRENT_DATE + (n % 60),
    CURRENT_DATE + (n % 60) + 2 + (n % 5),
    (2500 + n * 37.25)::numeric(12, 2),
    (ARRAY['confirmed', 'pending', 'cancelled', 'checked_in'])[n % 4 + 1],
    CURRENT_TIMESTAMP - (n % 45) * INTERVAL '1 day'
FROM generate_series(1, 120) AS booking_numbers(n);

INSERT INTO booking_events (booking_id, event_type, payload, created_at)
SELECT
    b.id,
    event.event_type,
    jsonb_build_object('source', 'seed', 'booking_status', b.status),
    b.created_at + event.event_offset
FROM (
    SELECT id, status, created_at, row_number() OVER (ORDER BY created_at, id) AS row_num
    FROM hotel_bookings
) AS b
CROSS JOIN (
    VALUES
        ('booking_created'::varchar, INTERVAL '0 minutes'),
        ('booking_updated'::varchar, INTERVAL '30 minutes')
) AS event(event_type, event_offset)
WHERE b.row_num % 3 = 0;
