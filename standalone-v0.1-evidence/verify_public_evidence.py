"""Check HPM v0.1 public evidence integrity; no runtime/third-party attestation."""
import hashlib
import json
from pathlib import Path

EXPECTED = {
    'HPM-v0.1-FREEZE-MANIFEST.json': '713AEE0634973873DE8AF3B63452EADD3D972A06D4D20CE6AFB88639E9749BE4',
    'HPM-v0.1-TEST-REPORT-20261009T150255345971Z.json': '51FCB8177CFC23E41DB0C07B12FC7D048A015FD5358C9408F5586726ADDCF357',
    'HPM-v0.1-TEST-RECEIPT-20261009T150255345971Z.json': '7376920EA8B5CDBDC359DF6EFAA96CCDF90C268C3172ADB859B6B292B99087DF',
}
REPORT = 'HPM-v0.1-TEST-REPORT-20261009T150255345971Z.json'
RECEIPT = 'HPM-v0.1-TEST-RECEIPT-20261009T150255345971Z.json'

def require(condition, message):
    if not condition:
        raise SystemExit('HOLD - ' + message)

def sha(raw):
    return hashlib.sha256(raw).hexdigest().upper()

def digest(obj):
    raw = json.dumps(obj, sort_keys=True, separators=(',', ':'), ensure_ascii=False, allow_nan=False).encode('utf-8')
    return hashlib.sha256(raw).hexdigest()

def main():
    folder = Path(__file__).resolve().parent / 'evidence'
    docs = {}
    for name, expected in EXPECTED.items():
        raw = (folder / name).read_bytes()
        require(sha(raw) == expected, 'evidence file SHA-256 mismatch: ' + name)
        docs[name] = json.loads(raw)
        require(isinstance(docs[name], dict), 'evidence is not a JSON object: ' + name)
    f, r, c = docs['HPM-v0.1-FREEZE-MANIFEST.json'], docs[REPORT], docs[RECEIPT]
    require(f['test_report']['sha256'] == EXPECTED[REPORT], 'freeze/report mismatch')
    require(f['test_receipt']['file_sha256'] == EXPECTED[RECEIPT], 'freeze/receipt mismatch')
    require(f['test_receipt']['canonical_receipt_sha256'] == c['receipt_sha256'], 'freeze canonical receipt mismatch')
    require(c['test_report_sha256'] == EXPECTED[REPORT], 'receipt/report SHA-256 mismatch')
    require(c['test_report_filename'] == REPORT, 'receipt/report identity mismatch')
    require(digest({k: v for k, v in c.items() if k != 'receipt_sha256'}) == c['receipt_sha256'], 'canonical receipt digest mismatch')
    require(r['status'] == 'PASS' and r['passed_tests'] == 10 and r['total_tests'] == 10, 'test status/count mismatch')
    require(isinstance(r.get('tests'), list) and len(r['tests']) == 10 and all(x.get('status') == 'PASS' for x in r['tests']), 'test rows mismatch')
    require(f['status'] == 'FROZEN_BOUNDED_STANDALONE' and f['tests_passed'] == 10 and f['tests_total'] == 10, 'freeze status/count mismatch')
    require(f['github_publication_authorized'] is False and f['eie_integration_authorized'] is False, 'historical freeze authority flags mismatch')
    require(f['test_runner_sha256'] == c['test_runner_sha256'] == r['test_runner_sha256'], 'test runner binding mismatch')
    require(f['source_files']['runtime']['sha256'] == c['runtime_sha256'] == r['runtime_sha256'], 'runtime binding mismatch')
    print('PASS - PUBLIC EVIDENCE BYTE INTEGRITY AND INTERNAL BINDINGS VERIFIED')
    print('LIMIT - No engine rerun, external attestation or EIE integration verified')

if __name__ == '__main__':
    main()
