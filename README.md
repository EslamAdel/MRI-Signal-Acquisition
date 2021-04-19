# MRI Signal Acquisition 
A simulation of MRI signal acquisition from 1D rod object. Investigation of effect of different parameters.


<img src="https://render.githubusercontent.com/render/math?math=s(t) = \int_{x} M(x) \times e^{-sj\pi k_xx} dx">


and 

$$ 
k_x(t) = \frac{\gamma}{2\pi} \int_{0}^{t} G_x(\tau) d\tau
$$

Where 
$$G_x(\tau)$$
is the gradient of in x direction.

## UI Simulation tool
![](images/GUI.png)

## Imaging Sequence

* Without Phase Accumulation

![](images/NPA.png)


* With Phase Accumulation
![](images/PA.png)


## Sampling time 

* Aliasing due to down sampling

![](images/AL1.png)

* Still aliasing exists while increasing recording time.
![](images/AL2.png)

## Field Of View (FOV)

Changing FOV will affect the spatial resolution

![](images/W50.png)
![](images/W100.png)


## T2 Effect

T2 represents an exponential decay weighting of the signal. 


![](images/T2_4.png)








