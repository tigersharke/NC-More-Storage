-- LUALOCALS < ---------------------------------------------------------
local minetest, core, nodecore, nc
    = minetest, core, nodecore, nc
-- LUALOCALS > ---------------------------------------------------------

local modname = core.get_current_modname()

local function temper(name, desc, sound, glow, dmg)

local form = "nc_lode_"..name..".png^[mask:nc_api_storebox_frame.png"

local side = "nc_lode_"..name..".png^(" .. form .. ")"

core.register_node(modname .. ":shelf_cauldron_"..name, {
		description = desc.. " Lode Cauldron",
		tiles = {side, side, form},
		selection_box = nc.fixedbox(),
		collision_box = nc.fixedbox(),
		groups = {
			cracky = 3,
			visinv = 1,
			lode_cube = 1,
			storebox = 2,
			totable = 1,
			scaling_time = 50,
			metallic = 1,
			lode_cauldron = 1,
			damage_touch = dmg
		},
		paramtype = "light",
		sunlight_propagates = true,
		sounds = nc.sounds(sound),
		storebox_access = function(pt) return pt.above.y > pt.under.y end,
	})

end

temper("annealed",	"Annealed",	"nc_lode_annealed",	false,	0)
temper("tempered",	"Tempered",	"nc_lode_tempered",	false,	0)
temper("hot",		"Glowing",	"nc_lode_annealed",	true,	0)

nc.register_craft({
		label = "heat lode cauldron",
		action = "cook",
		touchgroups = {flame = 3},
		neargroups = {coolant = 0},
		duration = 10,
		cookfx = true,
		nodes = {
			{
				match = {name = modname .. ":shelf_cauldron_annealed"},
				replace = modname .. ":shelf_cauldron_hot"
			},
		}
	})

nc.register_craft({
		label = "heat lode cauldron",
		action = "cook",
		touchgroups = {flame = 3},
		neargroups = {coolant = 0},
		duration = 10,
		cookfx = true,
		nodes = {
			{
				match = {name = modname .. ":shelf_cauldron_tempered"},
				replace = modname .. ":shelf_cauldron_hot"
			},
		}
	})

nc.register_craft({
		label = "hot cauldron annealing",
		action = "cook",
		touchgroups = {flame = 0},
		neargroups = {coolant = 0},
		duration = 30,
		priority = -1,
		cookfx = {smoke = true, hiss = true},
		nodes = {
            {
                match = {name = modname .. ":shelf_cauldron_hot"},
                replace = modname .. ":shelf_cauldron_annealed"
            }
        }
	})

nc.register_craft({
		label = "hot cauldron quenching",
		action = "cook",
		touchgroups = {flame = 0},
		neargroups = {coolant = 1},
		cookfx = true,
		nodes = {
            {
                match = {name = modname .. ":shelf_cauldron_hot"},
                replace = modname .. ":shelf_cauldron_tempered"
            }
        }
	})

nc.register_craft({
		label = "assemble cauldron",
		action = "stackapply",
		indexkeys = {"nc_lode:form"},
		wield = {name = "nc_lode:block_annealed"},
		consumewield = 1,
		nodes = {
			{
				match = {name = "nc_lode:form", empty = true},
				replace = modname .. ":shelf_cauldron_annealed"
			},
		}
	})

nc.register_craft({
		label = "recycle annealed cauldron",
		action = "pummel",
		toolgroups = {choppy = 4},
		indexkeys = {modname .. ":shelf_cauldron_annealed"},
		nodes = {
				{
				match = modname .. ":shelf_cauldron_annealed",
				replace = "air"
				}
				},
		items = {
				{name = "nc_lode:rod_annealed", count = 1, scatter = 3},
				{name = "nc_lode:rod_annealed", count = 1, scatter = 3},
				{name = "nc_lode:block_annealed", count = 1, scatter = 2}
				}
					})

nc.register_lode_anvil_recipe(-1, function(temper) return {
		label = "recycle cauldron",
		action = "pummel",
		toolgroups = {choppy = 4},
		indexkeys = {"wc_storage:shelf_cauldron_hot"},
		nodes = {
				{
				match = "wc_storage:shelf_cauldron_hot",
				replace = "air"
				}
				},
		items = {
				{name = "nc_lode:rod_hot", count = 1, scatter = 3},
				{name = "nc_lode:rod_hot", count = 1, scatter = 3},
				{name = "nc_lode:block_hot", count = 1, scatter = 2}
				}
			}
	 end )
	
-- With quench method for tempering this is not needed.

--nc.register_craft({
--		label = "assemble tempered cauldron",
--		action = "stackapply",
--		indexkeys = {"nc_lode:form"},
--		wield = {name = "nc_lode:block_tempered"},
--		consumewield = 1,
--		nodes = {
--			{
--				match = {name = "nc_lode:form", empty = true},
--				replace = modname .. ":shelf_cauldron_tempered"
--			},
--		}
--	})

