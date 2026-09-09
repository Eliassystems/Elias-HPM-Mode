function Invoke-HPMAssessment {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string]$Claim,

        [Parameter(Mandatory=$true)]
        [ValidateSet(
            'EMPIRICAL',
            'METAPHYSICAL',
            'PSYCHOLOGICAL',
            'IDENTITY_BOUND',
            'STRUCTURAL'
        )]
        [string]$Classification,

        [Parameter(Mandatory=$true)]
        [bool]$EvidencePresent,

        [Parameter(Mandatory=$true)]
        [bool]$DirectlyObserved,

        [Parameter(Mandatory=$true)]
        [bool]$InferenceRequired
    )

    $confidence = 'UNKNOWN'
    $epistemic_state = 'UNKNOWN'
    $admissible = $true
    $reasons = @()

    if ($DirectlyObserved -and $EvidencePresent -and -not $InferenceRequired) {
        $confidence = 'HIGH'
        $epistemic_state = 'OBSERVED'
    }
    elseif ($EvidencePresent -and $InferenceRequired) {
        $confidence = 'MODERATE'
        $epistemic_state = 'INTERPRETED'
        $reasons += 'INFERENCE_REQUIRED'
    }
    elseif (-not $EvidencePresent) {
        $confidence = 'UNKNOWN'
        $epistemic_state = 'UNKNOWN'
        $reasons += 'EVIDENCE_NOT_ESTABLISHED'
    }
    else {
        $confidence = 'LOW'
        $epistemic_state = 'UNRESOLVED'
        $reasons += 'INSUFFICIENT_BASIS_FOR_CERTAINTY'
    }

    [pscustomobject]@{
        hpm_version       = '1.0'
        claim             = $Claim
        classification    = $Classification
        epistemic_state   = $epistemic_state
        confidence        = $confidence
        admissible        = $admissible
        completion_forced = $false
        reasons           = $reasons
    }
}

Export-ModuleMember -Function Invoke-HPMAssessment
