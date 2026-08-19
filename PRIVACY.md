# Privacy

`dsh-verifier-trio` is a local DeepSeek Harness preset. The repository does not contain telemetry, analytics, tracking code, API credentials, model-provider configuration, session history, prompts, candidate outputs, cached responses, uploads, or user files.

## Runtime data

The preset asks DeepSeek Harness to create model candidates through the active session route. Requests, responses, retention, and provider-side processing therefore follow the model provider and privacy configuration already selected in the user's DSH installation. Installing this preset does not add another network service or data recipient.

## Repository verification

Published verification records contain only tool versions, structural event counts, and pass/fail outcomes. They must not contain prompts, model responses, hidden reasoning, session identifiers, local filesystem paths, provider keys, or token/account data.

## Local state

The preset itself does not persist a separate database. DeepSeek Harness may retain its normal session and application state according to the user's DSH configuration.
