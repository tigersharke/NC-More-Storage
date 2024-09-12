-- LUALOCALS < ---------------------------------------------------------
local include, nodecore
    = include, nodecore
-- LUALOCALS > ---------------------------------------------------------

include("wicker")				--NodeCore Alpha
include("thatch")				--NodeCore Alpha
include("floral")				--NodeCore Alpha
include("barrel")				--NodeCore Alpha
include("barrel_lode")			--NodeCore Alpha
include("flowerpot")			--NodeCore Alpha
include("lantern")				--NodeCore Alpha

include("carton")				--NodeCore Alpha
include("easter")				--NodeCore Alpha

include("crude")				--NodeCore Alpha
include("chromatic")			--NodeCore Alpha
include("sponge")				--NodeCore Alpha

include("cauldron_lode")			--NodeCore Alpha
include("toolrack")				--NodeCore Alpha
include("shelf_lode")			--NodeCore Alpha

include("powderkeg")			--NodeCore Alpha
include("hotbox")				--NodeCore Alpha

if minetest.get_modpath("nc_pummine") or minetest.get_modpath("wc_vulcan") then
	include("pumice")
	include("shrapnel")
end

if minetest.get_modpath("wc_naturae") then
	include("bamboo")
	include("thorns")
	include("hedge")
	include("funguspot")
	include("shell")
end

if minetest.get_modpath("wc_adamant") then
	include("adamant")
end

if minetest.get_modpath("wc_plumbum") then
	include("plumbum")
	include("fruit")
end

if minetest.get_modpath("wc_meltdown") then
	include("battery")
	include("core")
end

if minetest.get_modpath("nc_luxgate") then
	include("ilmenite")
end

if minetest.get_modpath("nc_cats") then
	include("catbox")
end

--include("euthamia")			--NC Euthamia

--include("sharktank")			--NC Sharks

--include("")
