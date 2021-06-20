[root](../README.md) / eigen.md
# Eigen

## Affine Transformation, rotation(), linear()
If you need the rotation matrix of a given affine transformation `Affine3d` than use the `linear()` method instead of the `rotation()` method. `linear()` returns the writable `Block<MatrixType,Dim,Dim,>` raw data, which can be optimised further by the compiler while `rotation()` returns a new (copy) `Transformation` object.

```c_cpp
Eigen::Affine3d T ...
Eigen::Vector3d p ...
...
const Eigen::Vector3d p_rot = T.rotation() * p; // slow
const Eigen::Vector3d p_rot = T.linear() * p;   // fast
```

## Conversations from other container
Eigen allows easy construction from other data containers. But you can also use the containers data directly avoiding copies.

```c_cpp
Eigen::Affine3d T ...
double points[99999];
...
// two copies
for(size_t i = 1; i < 99999; i=i+3){
	Eigen::Vector3d p(points + i, 3);			// first copy
	p = (T.linear()*p)+T.translation();
	std::copy(p.data(), p.data() + 3, points + i); // second copy
}
// zero copies
typedef Eigen::Map<Eigen::Vector3d> Mapper;
for(size_t i = 1; i < 99999; i=i+3){
	Mapper p(points + i, 3);
	p = (T.linear()*p)+T.translation();
}
```