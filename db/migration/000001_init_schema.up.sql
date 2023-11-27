CREATE TABLE "account"
(
    "id"         bigserial PRIMARY KEY,
    "owner"      varchar     NOT NULL,
    "balance"    bigint      NOT NULL,
    "currency"   varchar     NOT NULL,
    "created_at" timestamptz NOT NULL DEFAULT (now())
);

CREATE TABLE "entreis"
(
    "id"         bigserial PRIMARY KEY,
    "account_id" bigint      NOT NULL,
    "amount"     bigint      NOT NULL,
    "created_at" timestamptz NOT NULL DEFAULT (now())
);

CREATE TABLE "transfers"
(
    "id"              bigserial PRIMARY KEY,
    "from_account_id" bigint      NOT NULL,
    "to_account_id"   bigint      NOT NULL,
    "amount"          bigint      NOT NULL,
    "created_at"      timestamptz NOT NULL DEFAULT (now())
);

CREATE INDEX ON "account" ("owner");

CREATE INDEX ON "entreis" ("account_id");

CREATE INDEX ON "transfers" ("from_account_id");

CREATE INDEX ON "transfers" ("to_account_id");

CREATE INDEX ON "transfers" ("from_account_id", "to_account_id");

COMMENT
ON COLUMN "entreis"."amount" IS 'value can be negative and positive';

COMMENT
ON COLUMN "transfers"."amount" IS 'muse be positive';

ALTER TABLE "entreis"
    ADD FOREIGN KEY ("account_id") REFERENCES "account" ("id");

ALTER TABLE "transfers"
    ADD FOREIGN KEY ("from_account_id") REFERENCES "account" ("id");

ALTER TABLE "transfers"
    ADD FOREIGN KEY ("to_account_id") REFERENCES "account" ("id");
