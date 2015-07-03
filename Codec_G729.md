# Introduction #

I have begun to port ITU g729a codec implementation on iPhone OS.
I report below the performance and conformance between ITU reference implementation and my optimization.

For the moment the code is not released, but now the library is integrated in Siphon and it works fine(_because I haven't finished to integrate in Siphon_). Normally, a new version of Siphon should be released in September with g729a support.


# g729a #

## Performance ##

All tests have been realized on iPhone 1 with iPhone OS 2.2.1

### Coder ###
**coder g729a ITU (reference)**

| | sample.pcm | speech.pcm |
|:|:-----------|:-----------|
|Frame | 1969       | 3749       |
|real | 0m8.580s   | 0m15.902s  |
|user | 0m7.990s   | 0m15.110s  |
|sys  | 0m0.140s   | 0m0.190s   |

**coder g729a optimized**

| | sample.pcm | speech.pcm |
|:|:-----------|:-----------|
|Frame | 1969       | 3749       |
|real | 0m3.217s   | 0m5.939s   |
|user | 0m2.990s   | 0m5.670s   |
|sys  | 0m0.050s   | 0m0.080s   |


### Decoder ###

**decoder g729a ITU (reference)**

| | sample.pcm | speech.pcm |
|:|:-----------|:-----------|
|Frame | 1969       | 3749       |
|real | 0m1.865s   | 0m3.498s   |
|user | 0m1.740s   | 0m3.250s   |
|sys  | 0m0.050s   | 0m0.080s   |

**decoder g729a optimized**

| | sample.pcm | speech.pcm |
|:|:-----------|:-----------|
|Frame | 1969       | 3749       |
|real | 0m0.652s   | 0m1.576s   |
|user | 0m0.520s   | 0m0.990s   |
|sys  | 0m0.070s   | 0m0.070s   |

## References ##

|         |coder  |decoder| Description |
|:--------|:------|:------|:------------|
|algthm   |  ok   | ok    | conditional parts of the algorithm |
|erasure  |  N/A  | ok    | frame erasure recovery |
|fixed    |  ok   | ok    | fixed codebook search |
|lsp      |  ok   | ok    | lsp quantization |
|overflow |  N/A  | ok    | overflow detection in synthesizer |
|parity   |  N/A  | ok    | parity check |
|pitch    |  ok   | ok    | pitch search |
|speech   |  ok   | n/A   | generic speech file |
|tame     |  ok   | ok    | taming procedure |

## Platform ##

iPhone or iPod Touch, with arm ARM1176JZF.

# g729b or g729ab #

Next step.