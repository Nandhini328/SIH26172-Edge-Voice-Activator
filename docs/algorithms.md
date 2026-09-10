# Algorithms and Technical Approach

## 1. Ring buffer
A fixed-size circular buffer continuously stores recent PCM samples. New samples overwrite the oldest samples. This avoids repeated memory allocation and provides a deterministic sliding audio window.

## 2. Energy and ZCR fast rejection
Short-time energy estimates whether the incoming frame contains meaningful acoustic activity. Zero-crossing rate provides a lightweight spectral/noise indicator. Frames that clearly contain silence or unsuitable low-information content can be rejected before the neural network stage.

## 3. MFE/MFCC feature extraction
The audio waveform is transformed into compact time-frequency features. Mel-scale filterbanks emphasize perceptually relevant frequency regions, allowing a small neural network to classify acoustic patterns without operating directly on raw PCM.

## 4. Lightweight CNN / DS-CNN
A compact convolutional architecture learns local time-frequency patterns. Depthwise-separable convolution can reduce multiply-accumulate operations and parameter count compared with conventional convolution.

## 5. INT8 quantization
Weights and activations are represented with 8-bit integers. This reduces model memory footprint and is suitable for MCU inference. The current exported artifacts show a model-size reduction from 1561.2 KiB Float32 to 601.3 KiB INT8.

## 6. Confidence and temporal verification
A single high score is not necessarily sufficient to activate streaming. The final firmware should combine confidence thresholding with consecutive-frame or temporal confirmation and a cooldown/debounce period. This is intended to reduce false activations.

## Novelty / differentiation
The project is not novel merely because it uses a TinyML classifier. The intended contribution is the complete low-latency edge activation pipeline: continuous local wake-word detection, early inexpensive rejection, compact INT8 inference, temporal verification, and selective network activation only after a valid wake word. The final novelty claims should be supported by measured latency, false-activation, memory, CPU and power results on the target hardware.
