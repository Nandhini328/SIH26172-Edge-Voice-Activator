# Tests

## Current acceptance evidence

MATLAB inference over the 82-sample Edge Impulse test set:

- Correct: 80
- Incorrect: 2
- Accuracy: 97.56%
- Confusion matrix:
  - `hey_kira`: 3/3 correct
  - `noise`: 39/39 correct
  - `unknown`: 38/40 correct

## Hardware acceptance tests

- [ ] I2S audio capture is stable at the selected sample rate.
- [ ] Ring-buffer wraparound is correct.
- [ ] Feature extraction matches training preprocessing.
- [ ] INT8 inference produces expected class ordering.
- [ ] Wake-word detection latency is measured.
- [ ] False activations/hour are measured.
- [ ] Streaming begins only after confirmed wake word.
- [ ] Wi-Fi disconnect/reconnect is handled.
- [ ] Always-listening average power is measured.
- [ ] Memory and CPU utilization are measured.
