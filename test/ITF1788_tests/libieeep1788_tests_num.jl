#=
 
 Unit tests from libieeep1788 for interval numeric operations
 (Original author: Marco Nehmeier)
 converted into portable ITL format by Oliver Heimlich.
 
 Copyright 2013-2015 Marco Nehmeier (nehmeier@informatik.uni-wuerzburg.de)
 Copyright 2015-2017 Oliver Heimlich (oheim@posteo.de)
 
 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at
 
     http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 
=#
#Language imports

#Test library imports
using Test

#Arithmetic library imports
using IntervalArithmetic

#Preamble
setprecision(53)
setprecision(Interval, Float64)
setrounding(Interval, :tight)
# Set full format, and show decorations
@format full

@testset "minimal_inf_test" begin
    @test inf(∅) == Inf
    @test inf(Interval(-Inf, Inf)) == -Inf
    @test inf(Interval(1.0, 2.0)) == 1.0
    @test inf(Interval(-3.0, -2.0)) == -3.0
    @test inf(Interval(-Inf, 2.0)) == -Inf
    @test inf(Interval(-Inf, 0.0)) == -Inf
    @test inf(Interval(-Inf, -0.0)) == -Inf
    @test inf(Interval(-2.0, Inf)) == -2.0
    @test inf(Interval(0.0, Inf)) == -0.0
    @test inf(Interval(-0.0, Inf)) == -0.0
    @test inf(Interval(-0.0, 0.0)) == -0.0
    @test inf(Interval(0.0, -0.0)) == -0.0
    @test inf(Interval(0.0, 0.0)) == -0.0
    @test inf(Interval(-0.0, -0.0)) == -0.0
end

@testset "minimal_inf_dec_test" begin
    @test isnan(inf(nai()))
    @test inf(DecoratedInterval(∅, trv)) == Inf
    @test inf(DecoratedInterval(Interval(-Inf, Inf), def)) == -Inf
    @test inf(DecoratedInterval(Interval(1.0, 2.0), com)) == 1.0
    @test inf(DecoratedInterval(Interval(-3.0, -2.0), trv)) == -3.0
    @test inf(DecoratedInterval(Interval(-Inf, 2.0), dac)) == -Inf
    @test inf(DecoratedInterval(Interval(-Inf, 0.0), def)) == -Inf
    @test inf(DecoratedInterval(Interval(-Inf, -0.0), trv)) == -Inf
    @test inf(DecoratedInterval(Interval(-2.0, Inf), trv)) == -2.0
    @test inf(DecoratedInterval(Interval(0.0, Inf), def)) == -0.0
    @test inf(DecoratedInterval(Interval(-0.0, Inf), trv)) == -0.0
    @test inf(DecoratedInterval(Interval(-0.0, 0.0), dac)) == -0.0
    @test inf(DecoratedInterval(Interval(0.0, -0.0), trv)) == -0.0
    @test inf(DecoratedInterval(Interval(0.0, 0.0), trv)) == -0.0
    @test inf(DecoratedInterval(Interval(-0.0, -0.0), trv)) == -0.0
end

@testset "minimal_sup_test" begin
    @test sup(∅) == -Inf
    @test sup(Interval(-Inf, Inf)) == Inf
    @test sup(Interval(1.0, 2.0)) == 2.0
    @test sup(Interval(-3.0, -2.0)) == -2.0
    @test sup(Interval(-Inf, 2.0)) == 2.0
    @test sup(Interval(-Inf, 0.0)) == 0.0
    @test sup(Interval(-Inf, -0.0)) == 0.0
    @test sup(Interval(-2.0, Inf)) == Inf
    @test sup(Interval(0.0, Inf)) == Inf
    @test sup(Interval(-0.0, Inf)) == Inf
    @test sup(Interval(-0.0, 0.0)) == 0.0
    @test sup(Interval(0.0, -0.0)) == 0.0
    @test sup(Interval(0.0, 0.0)) == 0.0
    @test sup(Interval(-0.0, -0.0)) == 0.0
end

@testset "minimal_sup_dec_test" begin
    @test isnan(sup(nai()))
    @test sup(DecoratedInterval(∅, trv)) == -Inf
    @test sup(DecoratedInterval(Interval(-Inf, Inf), def)) == Inf
    @test sup(DecoratedInterval(Interval(1.0, 2.0), com)) == 2.0
    @test sup(DecoratedInterval(Interval(-3.0, -2.0), trv)) == -2.0
    @test sup(DecoratedInterval(Interval(-Inf, 2.0), dac)) == 2.0
    @test sup(DecoratedInterval(Interval(-Inf, 0.0), def)) == 0.0
    @test sup(DecoratedInterval(Interval(-Inf, -0.0), trv)) == 0.0
    @test sup(DecoratedInterval(Interval(-2.0, Inf), trv)) == Inf
    @test sup(DecoratedInterval(Interval(0.0, Inf), def)) == Inf
    @test sup(DecoratedInterval(Interval(-0.0, Inf), trv)) == Inf
    @test sup(DecoratedInterval(Interval(-0.0, 0.0), dac)) == +0.0
    @test sup(DecoratedInterval(Interval(0.0, -0.0), trv)) == +0.0
    @test sup(DecoratedInterval(Interval(0.0, 0.0), trv)) == +0.0
    @test sup(DecoratedInterval(Interval(-0.0, -0.0), trv)) == +0.0
end

@testset "minimal_mid_test" begin
    @test isnan(mid(∅))
    @test mid(Interval(-Inf, Inf)) == 0.0
    @test mid(Interval(-0x1.fffffffffffffP1023, +0x1.fffffffffffffP1023)) == 0.0
    @test mid(Interval(0.0, 2.0)) == 1.0
    @test mid(Interval(2.0, 2.0)) == 2.0
    @test mid(Interval(-2.0, 2.0)) == 0.0
    @test mid(Interval(0.0, Inf)) == 0x1.fffffffffffffP1023
    @test mid(Interval(-Inf, 1.2)) == -0x1.fffffffffffffP1023
    @test mid(Interval(-0x0.0000000000002p-1022, 0x0.0000000000001p-1022)) == 0.0
    @test mid(Interval(-0x0.0000000000001p-1022, 0x0.0000000000002p-1022)) == 0.0
    @test mid(Interval(0x1.fffffffffffffP+1022, 0x1.fffffffffffffP+1023)) == 0x1.7ffffffffffffp+1023
    @test mid(Interval(0x0.0000000000001p-1022, 0x0.0000000000003p-1022)) == 0x0.0000000000002p-1022
end

@testset "minimal_mid_dec_test" begin
    @test isnan(mid(DecoratedInterval(∅, trv)))
    @test isnan(mid(nai()))
    @test mid(DecoratedInterval(Interval(-Inf, Inf), def)) == 0.0
    @test mid(DecoratedInterval(Interval(-0x1.fffffffffffffP1023, +0x1.fffffffffffffP1023), trv)) == 0.0
    @test mid(DecoratedInterval(Interval(0.0, 2.0), com)) == 1.0
    @test mid(DecoratedInterval(Interval(2.0, 2.0), dac)) == 2.0
    @test mid(DecoratedInterval(Interval(-2.0, 2.0), trv)) == 0.0
    @test mid(DecoratedInterval(Interval(0.0, Inf), trv)) == 0x1.fffffffffffffP1023
    @test mid(DecoratedInterval(Interval(-Inf, 1.2), trv)) == -0x1.fffffffffffffP1023
    @test mid(DecoratedInterval(Interval(-0x0.0000000000002p-1022, 0x0.0000000000001p-1022), trv)) == 0.0
    @test mid(DecoratedInterval(Interval(-0x0.0000000000001p-1022, 0x0.0000000000002p-1022), trv)) == 0.0
    @test mid(DecoratedInterval(Interval(0x1.fffffffffffffP+1022, 0x1.fffffffffffffP+1023), trv)) == 0x1.7ffffffffffffp+1023
    @test mid(DecoratedInterval(Interval(0x0.0000000000001p-1022, 0x0.0000000000003p-1022), trv)) == 0x0.0000000000002p-1022
end

@testset "minimal_rad_test" begin
    @test radius(Interval(0.0, 2.0)) == 1.0
    @test radius(Interval(2.0, 2.0)) == 0.0
    @test isnan(radius(∅))
    @test radius(Interval(-Inf, Inf)) == Inf
    @test radius(Interval(0.0, Inf)) == Inf
    @test radius(Interval(-Inf, 1.2)) == Inf
    @test radius(Interval(-0x0.0000000000002p-1022, 0x0.0000000000001p-1022)) == 0x0.0000000000002p-1022
    @test radius(Interval(0x0.0000000000001p-1022, 0x0.0000000000002p-1022)) == 0x0.0000000000001p-1022
    @test radius(Interval(0x1p+0, 0x1.0000000000003p+0)) == 0x1p-51
end

@testset "minimal_rad_dec_test" begin
    @test radius(DecoratedInterval(Interval(0.0, 2.0), trv)) == 1.0
    @test radius(DecoratedInterval(Interval(2.0, 2.0), com)) == 0.0
    @test isnan(radius(DecoratedInterval(∅, trv)))
    @test isnan(radius(nai()))
    @test radius(DecoratedInterval(Interval(-Inf, Inf), trv)) == Inf
    @test radius(DecoratedInterval(Interval(0.0, Inf), def)) == Inf
    @test radius(DecoratedInterval(Interval(-Inf, 1.2), trv)) == Inf
    @test radius(DecoratedInterval(Interval(-0x0.0000000000002p-1022, 0x0.0000000000001p-1022), trv)) == 0x0.0000000000002p-1022
    @test radius(DecoratedInterval(Interval(0x0.0000000000001p-1022, 0x0.0000000000002p-1022), trv)) == 0x0.0000000000001p-1022
    @test radius(DecoratedInterval(Interval(0x1p+0, 0x1.0000000000003p+0), trv)) == 0x1p-51
end

@testset "minimal_mid_rad_test" begin
    @test midpoint_radius(∅) === (NaN, NaN)
    @test midpoint_radius(Interval(-Inf, Inf)) == (0.0, Inf)
    @test midpoint_radius(Interval(-0x1.fffffffffffffP1023, +0x1.fffffffffffffP1023)) == (0.0, 0x1.fffffffffffffP+1023)
    @test midpoint_radius(Interval(0.0, 2.0)) == (1.0, 1.0)
    @test midpoint_radius(Interval(2.0, 2.0)) == (2.0, 0.0)
    @test midpoint_radius(Interval(-2.0, 2.0)) == (0.0, 2.0)
    @test midpoint_radius(Interval(0, Inf)) == (0x1.fffffffffffffP+1023, Inf)
    @test midpoint_radius(Interval(-Inf, 1.2)) == (-0x1.fffffffffffffP+1023, Inf)
    @test midpoint_radius(Interval(-0x0.0000000000002p-1022, 0x0.0000000000001p-1022)) == (0.0, 0x0.0000000000002p-1022) 
    @test midpoint_radius(Interval(0x1.fffffffffffffP+1022, 0x1.fffffffffffffP+1023)) == (0x1.7FFFFFFFFFFFFP+1023, 0x1.0p+1022)
    @test midpoint_radius(Interval(0x0.0000000000001p-1022, 0x0.0000000000003p-1022)) == (0x0.0000000000002P-1022, 0x0.0000000000001P-1022)
end

@testset "minimal_mid_rad_dec_test" begin
    @test midpoint_radius(DecoratedInterval(∅, trv)) === (NaN, NaN)
    @test midpoint_radius(DecoratedInterval(Interval(-Inf, Inf), dac)) == (0.0, Inf)
    @test midpoint_radius(DecoratedInterval(Interval(-0x1.fffffffffffffP+1023, 0x1.fffffffffffffP+1023), trv)) == (0.0, 0x1.fffffffffffffP+1023)
    @test midpoint_radius(DecoratedInterval(Interval(0.0, 2.0), com)) == (1.0, 1.0)
    @test midpoint_radius(DecoratedInterval(Interval(2.0, 2.0), dac)) == (2.0, 0.0)
    @test midpoint_radius(DecoratedInterval(Interval(-2.0, 2.0), trv)) == (0.0, 2.0)
    @test midpoint_radius(DecoratedInterval(Interval(0, Inf), trv)) == (0x1.fffffffffffffP+1023, Inf)
    @test midpoint_radius(DecoratedInterval(Interval(-Inf, 1.2), trv)) == (-0x1.fffffffffffffP+1023, Inf)
    @test midpoint_radius(DecoratedInterval(Interval(-0x0.0000000000002P-1022, 0x0.0000000000001P-1022), trv)) == (0.0, 0x0.0000000000002P-1022)
    @test midpoint_radius(DecoratedInterval(Interval(-0x0.0000000000001P-1022, 0x0.0000000000002P-1022), trv)) == (0.0, 0x0.0000000000002P-1022)
    @test midpoint_radius(DecoratedInterval(Interval(0x1.fffffffffffffP+1022, 0x1.fffffffffffffP+1023), trv)) == (0x1.7FFFFFFFFFFFFP+1023, 0x1.0p+1022)
    @test midpoint_radius(DecoratedInterval(Interval(0x0.0000000000001P-1022, 0x0.0000000000003P-1022), trv)) == (0x0.0000000000002P-1022, 0x0.0000000000001P-1022)
end

@testset "minimal_wid_test" begin
    @test diam(Interval(2.0, 2.0)) == 0.0
    @test diam(Interval(1.0, 2.0)) == 1.0
    @test diam(Interval(1.0, Inf)) == Inf
    @test diam(Interval(-Inf, 2.0)) == Inf
    @test diam(Interval(-Inf, Inf)) == Inf
    @test isnan(diam(∅))
    @test diam(Interval(0x1p+0, 0x1.0000000000001p+0)) == 0x1p-52
    @test diam(Interval(0x1p-1022, 0x1.0000000000001p-1022)) == 0x0.0000000000001p-1022
end

@testset "minimal_wid_dec_test" begin
    @test diam(DecoratedInterval(Interval(2.0, 2.0), com)) == 0.0
    @test diam(DecoratedInterval(Interval(1.0, 2.0), trv)) == 1.0
    @test diam(DecoratedInterval(Interval(1.0, Inf), trv)) == Inf
    @test diam(DecoratedInterval(Interval(-Inf, 2.0), def)) == Inf
    @test diam(DecoratedInterval(Interval(-Inf, Inf), trv)) == Inf
    @test isnan(diam(DecoratedInterval(∅, trv)))
    @test isnan(diam(nai()))
    @test diam(DecoratedInterval(Interval(0x1p+0, 0x1.0000000000001p+0), trv)) == 0x1p-52
    @test diam(DecoratedInterval(Interval(0x1p-1022, 0x1.0000000000001p-1022), trv)) == 0x0.0000000000001p-1022
end

@testset "minimal_mag_test" begin
    @test mag(Interval(1.0, 2.0)) == 2.0
    @test mag(Interval(-4.0, 2.0)) == 4.0
    @test mag(Interval(-Inf, 2.0)) == Inf
    @test mag(Interval(1.0, Inf)) == Inf
    @test mag(Interval(-Inf, Inf)) == Inf
    @test isnan(mag(∅))
    @test mag(Interval(-0.0, 0.0)) == 0.0
    @test mag(Interval(-0.0, -0.0)) == 0.0
end

@testset "minimal_mag_dec_test" begin
    @test mag(DecoratedInterval(Interval(1.0, 2.0), com)) == 2.0
    @test mag(DecoratedInterval(Interval(-4.0, 2.0), trv)) == 4.0
    @test mag(DecoratedInterval(Interval(-Inf, 2.0), trv)) == Inf
    @test mag(DecoratedInterval(Interval(1.0, Inf), def)) == Inf
    @test mag(DecoratedInterval(Interval(-Inf, Inf), trv)) == Inf
    @test isnan(mag(DecoratedInterval(∅, trv)))
    @test isnan(mag(nai()))
    @test mag(DecoratedInterval(Interval(-0.0, 0.0), trv)) == 0.0
    @test mag(DecoratedInterval(Interval(-0.0, -0.0), trv)) == 0.0
end

@testset "minimal_mig_test" begin
    @test mig(Interval(1.0, 2.0)) == 1.0
    @test mig(Interval(-4.0, 2.0)) == 0.0
    @test mig(Interval(-4.0, -2.0)) == 2.0
    @test mig(Interval(-Inf, 2.0)) == 0.0
    @test mig(Interval(-Inf, -2.0)) == 2.0
    @test mig(Interval(-1.0, Inf)) == 0.0
    @test mig(Interval(1.0, Inf)) == 1.0
    @test mig(Interval(-Inf, Inf)) == 0.0
    @test isnan(mig(∅))
    @test mig(Interval(-0.0, 0.0)) == 0.0
    @test mig(Interval(-0.0, -0.0)) == 0.0
end

@testset "minimal_mig_dec_test" begin
    @test mig(DecoratedInterval(Interval(1.0, 2.0), com)) == 1.0
    @test mig(DecoratedInterval(Interval(-4.0, 2.0), trv)) == 0.0
    @test mig(DecoratedInterval(Interval(-4.0, -2.0), trv)) == 2.0
    @test mig(DecoratedInterval(Interval(-Inf, 2.0), def)) == 0.0
    @test mig(DecoratedInterval(Interval(-Inf, -2.0), trv)) == 2.0
    @test mig(DecoratedInterval(Interval(-1.0, Inf), trv)) == 0.0
    @test mig(DecoratedInterval(Interval(1.0, Inf), trv)) == 1.0
    @test mig(DecoratedInterval(Interval(-Inf, Inf), trv)) == 0.0
    @test isnan(mig(DecoratedInterval(∅, trv)))
    @test isnan(mig(nai()))
    @test mig(DecoratedInterval(Interval(-0.0, 0.0), trv)) == 0.0
    @test mig(DecoratedInterval(Interval(-0.0, -0.0), trv)) == 0.0
end
# FactCheck.exitstatus()
