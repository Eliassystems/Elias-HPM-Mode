# Evidence Verification (Publicly Available Bytes Only)

A reader can verify the published **evidence records**, but cannot reproduce the test run without the unpublished engine and runner.

1. Run `python -B verify_public_evidence.py` from this package's root with Python 3.10+.
2. The checker verifies pinned SHA-256 bytes for the three original evidence JSON files, the canonical receipt digest (omitting `receipt_sha256`), report↔receipt links, and freeze↔report↔receipt links.
3. A passing result confirms only record consistency and byte integrity under the declared hash pins. It does not authenticate when or by whom tests were run or establish third-party attestation.

The original freeze manifest contains source hashes for the **unpublished** runtime/contract/requirements/runner. Those source hashes are historical identifiers only and cannot be independently recalculated from this public disclosure package.

Do not rewrite the historical freeze manifest to change its publication flags. Review/approval is a separate event and record, not retrospective repair.
