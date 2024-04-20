include("../src/sphericalHarmonicsExpansion.jl")

@polyvar c[1:4]
@polyvar x y z

f_new = sphericalHarmonicsExpansion(c, x, y, z)
print(f_new)