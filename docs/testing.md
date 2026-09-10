# Verification and Testing Plan

## Stage 1 – Audio acquisition
- Verify 16 kHz mono PCM capture.
- Inspect sample continuity and amplitude range.
- Confirm no clipping and acceptable noise floor.

## Stage 2 – Buffering
- Verify ring-buffer wraparound.
- Confirm fixed memory usage.
- Measure window availability and pre-roll behavior.

## Stage 3 – Feature extraction
- Compare embedded features against the training/export pipeline.
- Check feature dimensions and numeric range.

## Stage 4 – ML inference
- Verify the same test samples used in MATLAB/Edge Impulse.
- Confirm class ordering: `hey_kira`, `noise`, `unknown`.
- Record inference time, RAM and flash usage.

## Stage 5 – Decision logic
- Sweep confidence thresholds.
- Measure false activations and missed wake words.
- Add temporal confirmation and cooldown.

## Stage 6 – Streaming
- Measure wake-word-to-first-audio-packet latency.
- Measure packet loss and reconnection behavior.
- Verify that streaming starts only after activation.

## Stage 7 – Power
- Measure voltage and current in Listening, Wake detected and Streaming states.
- Calculate P = V × I.
- Report the measured always-listening average against the <50 mW target.

## Stage 8 – End-to-end test
- Quiet environment.
- Speech at different distances.
- Background speech.
- Fan/room noise.
- Multiple speakers.
- Repeated wake-word attempts.
- Wi-Fi unavailable/reconnection.

## Current verified result
MATLAB reproduces the supplied 82-sample INT8 test result: 80/82 correct, 97.56% accuracy, with confusion matrix `[3 0 0; 0 39 0; 1 1 38]`.
