$ErrorActionPreference = 'Stop'

Import-Module "$PSScriptRoot\..\src\HPM.psm1" -Force

$Observed = Invoke-HPMAssessment `
    -Claim "Control observation established" `
    -Classification EMPIRICAL `
    -EvidencePresent $true `
    -DirectlyObserved $true `
    -InferenceRequired $false

$Unknown = Invoke-HPMAssessment `
    -Claim "Unverified proposition" `
    -Classification EMPIRICAL `
    -EvidencePresent $false `
    -DirectlyObserved $false `
    -InferenceRequired $false

$Interpreted = Invoke-HPMAssessment `
    -Claim "Evidence-supported inferred proposition" `
    -Classification STRUCTURAL `
    -EvidencePresent $true `
    -DirectlyObserved $false `
    -InferenceRequired $true

if ($Observed.epistemic_state -ne 'OBSERVED' -or $Observed.confidence -ne 'HIGH') {
    throw "OBSERVED CONTROL FAILED"
}

if ($Unknown.epistemic_state -ne 'UNKNOWN' -or $Unknown.confidence -ne 'UNKNOWN') {
    throw "UNKNOWN PRESERVATION FAILED"
}

if ($Unknown.completion_forced -ne $false) {
    throw "UNKNOWN STATE WAS IMPROPERLY FORCED TO COMPLETION"
}

if ($Interpreted.epistemic_state -ne 'INTERPRETED' -or $Interpreted.confidence -ne 'MODERATE') {
    throw "INTERPRETED STATE FAILED"
}

if ($Interpreted.reasons -notcontains 'INFERENCE_REQUIRED') {
    throw "INFERENCE BOUNDARY FAILED"
}

Write-Host "HPM-EPIS-001 PASS"
Write-Host "OBSERVED: $($Observed.epistemic_state) / $($Observed.confidence)"
Write-Host "UNKNOWN: $($Unknown.epistemic_state) / $($Unknown.confidence)"
Write-Host "INTERPRETED: $($Interpreted.epistemic_state) / $($Interpreted.confidence)"
Write-Host "COMPLETION_FORCED: $($Unknown.completion_forced)"
