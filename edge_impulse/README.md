# Edge Impulse Model

The current model was trained/exported through Edge Impulse for the three-class keyword-spotting task:

- `hey_kira`
- `noise`
- `unknown`

## Current exported artifacts

- Float32 TensorFlow Lite model
- INT8 quantized TensorFlow Lite model
- MFE feature arrays for training/testing

## MATLAB reproduction

The exported INT8 model was loaded in MATLAB and evaluated on 82 testing samples. The reproduced result was 80/82 correct (**97.56% accuracy**) with the confusion matrix:

```text
3   0   0
0  39   0
1   1  38
```

Binary model/data files are excluded from the normal Git history. Store final artifacts using Git LFS or GitHub Releases when the team is ready.
