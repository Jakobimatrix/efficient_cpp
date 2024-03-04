#programming #cpp
[root](../README.md) / eigen.md
# Eigen

## Affine Transformation, rotation(), linear()
If you need the rotation matrix of a given affine transformation `Affine3d, Isometry3d` consider use the `linear()` method instead of the `rotation()` method. `linear()` returns the writable `Block<MatrixType,Dim,Dim,>` raw data, which can be optimized further by the compiler while `rotation()` returns a new (copy) `Transformation` object.

```c_cpp
Eigen::Isometry3d T ...
Eigen::Isometry3d p ...
...
const Eigen::Vector3d p_rot = T.rotation() * p; // slow
const Eigen::Vector3d p_rot = T.linear() * p;   // fast
```

## Affine Inverse
If you need the inverse of an Isometry/Affine3d you should give a hint to the compiler. Inverting Affine transformation can be done with simple transpose and multiplication!

```c_cpp
const Eigen::Isometry3d T = ...
...
const Eigen::Isometry3d T_inv = T.inverse(); // slow uses solver, will produce numerical inaccuracies
const Eigen::Isometry3d T_inv = T.inverse(Eigen::TransformTraits::Isometry); // fast, numerical more accurate.
const Eigen::Affine3d T_inv2 = T2.inverse(Eigen::TransformTraits::Affine);
```

## Conversations from other container
Eigen allows easy construction from other data containers. But you can also use the containers data directly avoiding copies.

```c_cpp
Eigen::Isometry3d T ...
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