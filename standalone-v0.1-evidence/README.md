# ELIAS HPM v0.1 — Evidence-Led High Precision Mode

**Publication status: PUBLIC EVIDENCE DISCLOSURE — authorized 9 October 2026.**

## What HPM is

HPM is a bounded evidence-assessment component developed by Elias Systems to support more disciplined reasoning over explicitly provided claims, declared evidence relationships, and uncertainty. It is distinct from ordinary conversational style prompting. This evidence publication documents a local standalone evaluation contract, **not** that a language model obeys HPM in every answer.

The standalone evaluator accepts a claim and described evidence items and declares one of five bounded assessment outcomes: `SUPPORTED`, `QUALIFIED`, `NOT_ESTABLISHED`, `CONTRADICTED`, or `INSUFFICIENT_INPUT`. These are **assessments of the provided evidence relationships**; they are not independent judgments that the underlying claim is true or false.

## Test results

On 9 October 2026 a local synthetic test runner reported **10 of 10 cases passing** against HPM v0.1 standalone runtime. Cases covered declared support and contradiction, insufficient and qualified evidence, invalid-reference rejection, four invalid-input examples, deterministic identity and hashing, non-mutation, and declared verification boundary. See `evidence/` for the original byte-for-byte local test report, local receipt and bounded freeze manifest.

The runtime, engine contract, requirements and test-runner source code are **not included in this public evidence disclosure**. Their SHA-256 fingerprints are preserved in the manifest to maintain local evidence traceability, not to imply public executability.

## Limits of the evidence

- Local synthetic tests only; no independent verification of real-world evidence truth or evidence-source authenticity.
- No proof of LLM response quality, universal HPM compliance, or resistance to all prompt-injection strategies.
- No authorization or enforcement of consequential real-world actions.
- No external attestation or independent replication of the proprietary engine.
- No EIE integration, Standard/EPL three-mode regression test, phone deployment or user pilot established by these tests.
- SHA-256 checks support byte integrity and traceability; **hashes alone do not prove authorship, runtime behavior, execution time, or independent validation**.

## Status and next steps

`FROZEN_BOUNDED_STANDALONE` identifies the original local runtime and artifacts in the historical manifest. Its `github_publication_authorized: false` and `eie_integration_authorized: false` flags reflect the state **when the freeze was recorded**. Those flags are the preserved historical state. A separate public disclosure authorization was recorded on 9 October 2026 (see `PUBLICATION-AUTHORIZATION.md`). **This authorization permits publication of this bounded evidence package only; it does not authorize EIE integration, real-world execution, or broader technical claims.** The earlier HPM v1.0 repository baseline and its evidence remain separate and unchanged.

See `VERIFY.md` for which checks a public reader can actually perform.

## Relationship to the existing HPM repository

This `standalone-v0.1-evidence/` collection documents an independently scoped **standalone evidence assessor** and should not be confused with, or treated as a supersession of, the previously published **HPM v1.0 baseline** in this repository. Numbering applies to its own local evaluation contract.
