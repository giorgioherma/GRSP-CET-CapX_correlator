# GRSP Correlator 0.1.0

First working post-processing correlator.

## Included

- automatic discovery from a combined folder or ZIP
- GRSP/CET Unix-clock alignment
- automatic CapFrameX-to-GRSP frame-sequence alignment
- synchronization-health scoring
- common 50 ms timeline
- exact CET spike overlap matching
- 0-Engine scheduler spike matching
- GRSP per-frame and spike evidence
- bad-frame evidence classes
- self-contained interactive HTML report
- combined frame, timeline and hitch CSV exports
- zero third-party Python runtime dependencies
- GitHub Actions Windows one-file EXE build

## Deliberately not included

- naïve `frametime - GRSP - CET` remainder math
- uninstall recommendations
- dependency assumptions
- changes to the GRSP DLL hot path
- changes to CET profiler alpha6b
