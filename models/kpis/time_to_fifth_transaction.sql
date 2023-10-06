select

    round(avg(days_since_store_onboarding)) as average_days_to_fifth_transaction

from {{ ref('stg_successful_transaction_detailed') }}

where
    store_transaction_number = 5
    and days_since_store_onboarding > 0
