include("../src/sphericalHarmonicsExpansion.jl")
include("../src/sphericalHarmonic.jl")

using MultivariatePolynomials
using Distributions

using BenchmarkTools
using TypedPolynomials
# using DynamicPolynomials

function assertEquivalent()
    TypedPolynomials.@polyvar x y z

    L = 1
    c = SphericalHarmonicCoefficients(L)
    c[0,0] = 42.0
    c[1,-1] = 1.0
    c[1,0] = 2.0
    c[1,1] = 3.0
    f_old = sphericalHarmonicsExpansion(c, x, y, z)
    println(f_old)

    TypedPolynomials.@polyvar c[1:4]
    f_new = sphericalHarmonicsExpansion(c, x, y, z)(c => [42.0, 1.0, 2.0, 3.0])
    println(f_new)
end

function benchmarkTyped(runs=1000)
    for i in 1:runs
        TypedPolynomials.@polyvar x y z
        TypedPolynomials.@polyvar c[1:4]
        sphericalHarmonicsExpansion(c, x, y, z)
    end
end

# function benchmarkDynamic(runs=1000)
#     for i in 1:runs
#         DynamicPolynomials.@polyvar x y z
#         DynamicPolynomials.@polyvar c[1:4]
#         sphericalHarmonicsExpansion(c, x, y, z)
#     end
# end

assertEquivalent()

# @btime benchmarkTyped()
# @btime benchmarkDynamic()

# benchmark = @benchmark benchmarkTyped() setup=(data=1)
# dump(benchmark)
# @benchmark benchmarkTyped() setup=(data=1)