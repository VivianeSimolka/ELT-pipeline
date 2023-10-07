# SumUp Technical Test

## Goal of the exercise

Based on the three provided files (device, store and transaction), provide following KPIs:
- Top 10 stores per transacted amount
- Top 10 products sold
- Average transacted amount per store, typology and country
- Percentage of transactions per device type
- Average time for a store to perform its 5 first transactions


## Assumptions

The transaction file contains two timestamps: `created_at` and `happened_at`.
Considering the range of timespan between the two timestamps (going up to above 12,000 hours), it could not be a time zone difference.
For sake of simplicity, I decided to only use the `created_at` timestamp that I consider as the transaction time (as it minimized the number of transaction that happened before the store `created_at` field).

Considering the KPI requested, I assumed that we were only interested in successful transactions.
(Although it would be interesting to look into failed and rejected transactions).

Considering there is no information on product quantity sold, I am assuming each transaction correspond on only one item sold.

The field `created_at` from the store file is considered to be the onboarding time (timestamp when the store has for the first time a fully functional device, named as `store_onboarding_timestamp`).

## Set-up

To mirror SumUp set-up, the project is using **dbt** and **Snowflake**.

To Make the project run locally, follow those steps:
- create a new virtual environment
- run `pip install -r requirements.txt`
- create an account on Snowflake (if you do not have already one)
- if you do not have yet a dbt profile set-up:
  - run `mkdir ~/.dbt`
  - run `touch ~/.dbt/profiles.yml`
  - run
  ```
  echo -e
  snowflake:
  outputs:
    dev:
      account: <snowflake-account>
      database: <database>
      password: <password>
      role: <role>
      schema: <dev-schema>
      threads: 4
      type: snowflake
      user: <user>
      warehouse: <warehouse>
    prod:
      account: <snowflake-account>
      database: <database>
      password: <password>
      role: <role>
      schema: <prod-schema>
      threads: 4
      type: snowflake
      user: <user>
      warehouse: <warehouse>
  target: dev
  >> ~/.dbt/profiles.yml```

## Models

1. **Sources**

For sake of simplicity, source files are loaded as seeds, after converting those to csv.

2. **Ingestion layer**

Ingestion models, with renamed fields for more explicity and casting field with timestamp information to type timestamp.

3. **Stage layer**

All ingestion models are joined together to get detailed transaction information.

4. **Mart layer**

Overview with transaction KPIs by store, product and device.

5. **KPIs**

Models provided all answer to the technical test.

## Results

### Top 10 stores per transacted amount

Model `top_ten_stores_per_transaction_amount`

| STORE_ID | STORE_NAME                     | TRANSACTION_AMOUNT |
|----------|--------------------------------|--------------------|
| 3        | Nec Ante Ltd                   | 9,383              |
| 97       | Sem Ut Cursus Corp.            | 8,909              |
| 19       | Magnis Dis Inc.                | 7,334              |
| 82       | Blandit At Nisi Inc.           | 7,326              |
| 42       | Volutpat Nunc Sit Institute    | 6,853              |
| 51       | Mauris Aliquam PC              | 6,739              |
| 65       | Mauris Sit Amet Associates     | 6,722              |
| 85       | Ultrices Posuere Cubilia Corp. | 6,143              |
| 79       | Pede Ultrices Corporation      | 5,946              |
| 57       | Sapien Nunc Pulvinar Institute | 5,926              |

### Top 10 products sold

Model `top_ten_product_sold`

| PRODUCT_SKU   | PRODUCT_NAME    | TRANSACTION_COUNT |
|---------------|-----------------|-------------------|
| 3770009015050 | erat vitae      | 31                |
| 3770009015043 | blandit at,     | 29                |
| 3770009015172 | Curae Phasellus | 28                |
| 3770009015075 | vitae dolor.    | 28                |
| 3770009015052 | justo. Proin    | 27                |
| 3770009015048 | semper tellus   | 27                |
| 3770009015051 | sem semper      | 27                |
| 3770009015074 | tempor augue    | 27                |
| 3770009015042 | aliquet nec,    | 25                |
| 3770009015044 | justo. Proin    | 24                |

### Average transacted amount per store, typology and country

##### Average transacted amount per store

Model `avg_transacted_amount_per_store`

| STORE_ID | STORE_NAME                         | AVG_TRANSACTED_AMOUNT |
|----------|------------------------------------|-----------------------|
| 45       | Ut Institute                       | 961                   |
| 55       | Aliquam Corp.                      | 894.5                 |
| 23       | Non LLP                            | 872                   |
| 10       | At Libero Limited                  | 822                   |
| 47       | Lorem Foundation                   | 749                   |
| 98       | Magna Suspendisse Tristique PC     | 733                   |
| 53       | Sed Incorporated                   | 708                   |
| 8        | In LLP                             | 702                   |
| 62       | Semper Erat In Institute           | 696                   |
| 6        | Mauris Nulla Integer Foundation    | 693                   |
| 80       | Erat Industries                    | 672.17                |
| 25       | Nulla Magna Ltd                    | 671.5                 |
| 63       | Hendrerit Consectetuer PC          | 653                   |
| 30       | Cursus Nunc Mauris Industries      | 651.67                |
| 46       | Integer Mollis Integer Foundation  | 614.67                |
| 75       | Erat Neque Foundation              | 613.2                 |
| 38       | A Tortor Industries                | 610.8                 |
| 70       | Semper Institute                   | 610.5                 |
| 16       | Cum Sociis Natoque PC              | 605.6                 |
| 7        | Mauris Morbi PC                    | 602                   |
| 9        | Magna Corporation                  | 601.5                 |
| 79       | Pede Ultrices Corporation          | 594.6                 |
| 67       | Nullam Vitae Corp.                 | 584.75                |
| 92       | Tempus Mauris Ltd                  | 583.25                |
| 88       | Aliquam Eros Turpis Institute      | 583                   |
| 27       | Duis Sit Incorporated              | 578.5                 |
| 42       | Volutpat Nunc Sit Institute        | 571.08                |
| 37       | Sit Industries                     | 565.33                |
| 19       | Magnis Dis Inc.                    | 564.15                |
| 82       | Blandit At Nisi Inc.               | 563.54                |
| 76       | Sed Corp.                          | 563.38                |
| 85       | Ultrices Posuere Cubilia Corp.     | 558.45                |
| 73       | Arcu Vestibulum Ltd                | 558                   |
| 56       | Sit Amet Ornare Company            | 549                   |
| 49       | Id Ante Nunc LLC                   | 543.83                |
| 99       | Vitae Nibh Donec Inc.              | 542.67                |
| 84       | Quis LLP                           | 540.33                |
| 21       | Pede Suspendisse Company           | 534.2                 |
| 72       | Dis Parturient Montes PC           | 522                   |
| 51       | Mauris Aliquam PC                  | 518.38                |
| 65       | Mauris Sit Amet Associates         | 517.08                |
| 77       | At Sem Molestie Consulting         | 513.29                |
| 91       | Dignissim Lacus Foundation         | 508.4                 |
| 31       | Neque Tellus PC                    | 490.7                 |
| 22       | Tincidunt Nunc Industries          | 490                   |
| 96       | Molestie Dapibus Ligula Foundation | 478.75                |
| 86       | Nec Diam Corp.                     | 477.5                 |
| 11       | Lectus Rutrum Corporation          | 472.17                |
| 3        | Nec Ante Ltd                       | 469.15                |
| 17       | Adipiscing Corp.                   | 456.86                |
| 52       | Volutpat Nunc PC                   | 452.5                 |
| 78       | Ac Orci Ut PC                      | 450.13                |
| 20       | Metus Aliquam Associates           | 443.33                |
| 41       | Nec LLC                            | 442.67                |
| 64       | Aliquet Magna LLP                  | 427                   |
| 97       | Sem Ut Cursus Corp.                | 424.24                |
| 68       | Lorem Vehicula Inc.                | 424                   |
| 57       | Sapien Nunc Pulvinar Institute     | 423.29                |
| 34       | Et Netus Corporation               | 422                   |
| 95       | Nullam Suscipit Est PC             | 413.57                |
| 71       | Libero Lacus Corp.                 | 399.5                 |
| 74       | Dolor Nonummy Ac Inc.              | 392.5                 |
| 61       | Elementum Sem Corp.                | 387.2                 |
| 60       | Eleifend Cras Institute            | 380.85                |
| 93       | In Mi Institute                    | 375                   |
| 69       | Felis Purus Institute              | 373.67                |
| 12       | Eu Nibh LLC                        | 372.14                |
| 87       | Luctus Ut Ltd                      | 368.6                 |
| 26       | Ullamcorper Duis At Limited        | 354.5                 |
| 28       | Et Magna Incorporated              | 350.07                |
| 58       | Tortor Dictum Eu Industries        | 346                   |
| 1        | Vulputate Risus PC                 | 322.67                |
| 59       | Aliquam Vulputate LLC              | 295.75                |
| 36       | Et Malesuada Company               | 282                   |
| 90       | Libero Est LLC                     | 278.5                 |
| 13       | At LLP                             | 273                   |
| 24       | Mollis Dui LLP                     | 270                   |
| 39       | Nisl Elementum Foundation          | 222                   |
| 5        | Ac Turpis Limited                  | 136                   |
| 44       | Velit LLC                          | 101                   |

##### Average transacted amount per typology

Model `avg_transacted_amount_per_typology`

| STORE_TYPOLOGY | AVG_TRANSACTION_AMOUNT |
|----------------|------------------------|
| Hotel          | 523.53                 |
| Service        | 520.14                 |
| Beauty         | 518.95                 |
| Other          | 516.29                 |
| Florist        | 497.47                 |
| Press          | 495.08                 |
| Restaurant     | 478.92                 |
| FoodTruck      | 449.49                 |

##### Average transacted amount per country

Model `avg_transacted_amount_per_country`

| STORE_COUNTRY  | AVG_TRANSACTION_AMOUNT |
|----------------|------------------------|
| Vietnam        | 961                    |
| Norway         | 733                    |
| United States  | 696                    |
| Colombia       | 671.5                  |
| New Zealand    | 586.75                 |
| Austria        | 577.42                 |
| India          | 562.25                 |
| South Africa   | 547.89                 |
| South Korea    | 546.09                 |
| Mexico         | 545.5                  |
| Ireland        | 537.15                 |
| Brazil         | 529.6                  |
| China          | 517.7                  |
| Netherlands    | 516.27                 |
| Italy          | 512.43                 |
| Costa Rica     | 496.44                 |
| Belgium        | 492.33                 |
| Germany        | 491.38                 |
| Peru           | 475.62                 |
| Australia      | 473.91                 |
| Nigeria        | 468.1                  |
| Indonesia      | 463.92                 |
| Ukraine        | 460.75                 |
| France         | 444.45                 |
| Spain          | 442.67                 |
| United Kingdom | 432.88                 |
| Sweden         | 413.57                 |
| Singapore      | 404                    |
| Poland         | 392.5                  |
| Canada         | 350.07                 |
| Chile          | 101                    |

### Percentage of transactions per device type

Model `device_type_contribution`

| DEVICE_TYPE | DEVICE_TYPE_TRANSACTION_PERCENTAGE |
|-------------|------------------------------------|
| 1           | 23.77                              |
| 2           | 19.06                              |
| 3           | 18.03                              |
| 4           | 21.72                              |
| 5           | 17.42                              |

### Average time for a store to perform its 5 first transactions

Model `time_to_fifth_transaction`

There are a significant amount of transaction being made before the store onboarding time.
The calculation is excluding any stores that have a their 5th transaction before their onboarding time.

| AVERAGE_DAYS_TO_FIFTH_TRANSACTION |
|-----------------------------------|
| 128                               |

Although I calculated an average of 128 days, I would not communicate this KPI to any decision maker.
As the store onboarding timestamp doesn't seem very reliable, there could be something is wrong whether in my calculations or on the base data.

As an alternative, I looked into the time between the 1st and the 5th transaction (model `time_between_first_and_fifth_transaction`), as the I cannot ensure the accuracy of the field `store_onboarding_timestamp`.
Even though it does not answer the question, it is a more reliable KPI, as we know that at the time of the first transaction, the store as a functioning device in its possession.

| DAYS_FROM_FIRST_TO_FIFTH |
|--------------------------|
| 72                       |


## Going further

If I would have more time and access to information, I would first look into:

1. **Investigating store onboarding and transaction timestamp**

Starting with validating the assumption and column name definition, and if the issue remains, moving on to investigating potential issue with the source data.

3. **Add proper documentation**

Define all columns in a `docs.md` file and link the `schema.yml` to it.

Example `docs.md`:

```

{% docs store_onboarding_timestamp %}

Timestamp when the store has for the first time a fully functional device.

{% enddocs %}

```
Example `schema.yml`:

```
  - name: store_overview
    columns:
      - name: store_onboarding_timestamp
        description: "{{ doc('store_onboarding_timestamp') }}"

```

4. **Create an automatic ingestion**

In a real setting, the source data would not be static.
Hence the need to establish a connection.

For small data sources, I would use a cloud base platform such as Fivetran or Airbyte, as it is extremely fast to set-up.
At the scale of SumUp (millions or billions of records), such tool would be too expensive and a custom made ingestion would be necessary.

5. **Looking into cancelled and rejected transactions**

In the scope of this exercise, all KPIs required to filter transaction to keep only successful ones (accepted).
However, there would be value in investigating cancelled and refused ones.
Issues could then be proactively resolved, improving NPS and reducing churn.
