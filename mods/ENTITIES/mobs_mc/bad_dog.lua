--MCmobs v0.4
--maikerumine
--made for MC like Survival game
--License for code WTFPL and otherwise stated in readmes

local S = minetest.get_translator("mobs_mc")

--###################
--################### ZOMBIE
--###################

local drops_common = {
	{name = mobs_mc.items.rotten_flesh,
	chance = 1,
	min = 0,
	max = 2,},
	{name = mobs_mc.items.iron_ingot,
	chance = 120, -- 2.5% / 3
	min = 1,
	max = 1,},
	{name = mobs_mc.items.carrot,
	chance = 120, -- 2.5% / 3
	min = 1,
	max = 1,},
	{name = mobs_mc.items.potato,
	chance = 120, -- 2.5% / 3
	min = 1,
	max = 1,},
}

local drops_zombie = table.copy(drops_common)
table.insert(drops_zombie, {
	-- Zombie Head
	-- TODO: Only drop if killed by charged creeper
	name = mobs_mc.items.head_zombie,
	chance = 200, -- 0.5%
	min = 1,
	max = 1,
})


-- Collar colors
local colors = {
	["unicolor_black"] = "#000000",
	["unicolor_blue"] = "#0000BB",
	["unicolor_dark_orange"] = "#663300", -- brown
	["unicolor_cyan"] = "#01FFD8",
	["unicolor_dark_green"] = "#005B00",
	["unicolor_grey"] = "#C0C0C0",
	["unicolor_darkgrey"] = "#303030",
	["unicolor_green"] = "#00FF01",
	["unicolor_red_violet"] = "#FF05BB", -- magenta
	["unicolor_orange"] = "#FF8401",
	["unicolor_light_red"] = "#FF65B5", -- pink
	["unicolor_red"] = "#FF0000",
	["unicolor_violet"] = "#5000CC",
	["unicolor_white"] = "#FFFFFF",
	["unicolor_yellow"] = "#FFFF00",

	["unicolor_light_blue"] = "#B0B0FF",
}

local get_dog_textures = function(color)
	if colors[color] then
		return {"mobs_mc_wolf_tame.png^(mobs_mc_wolf_collar.png^[colorize:"..colors[color]..":192)"}
	else
		return nil
	end
end

local bad_dog = {
	type = "monster",
	hp_min = 20,
	hp_max = 20,
	breath_max = -1,
	armor = 90,
	collisionbox = {-0.3, -0.01, -0.3, 0.3, 0.84, 0.3}, --jon-- {-0.3, -0.01, -0.3, 0.3, 1.94, 0.3},
	visual = "mesh",
	mesh = "mobs_mc_wolf.b3d",
	textures = {
		--{get_dog_textures("unicolor_red")},
		{"mobs_mc_wolf_tame.png"}, --if both enabled, 50%
	},
	visual_size = {x=3, y=3},
	makes_footstep_sound = true,
	sounds = {
		random = "mobs_mc_zombie_growl",
		war_cry = "mobs_mc_zombie_growl",
		death = "mobs_mc_zombie_death",
		damage = "mobs_mc_zombie_hurt",
		distance = 16,
	},
	walk_velocity = .8,
	run_velocity = 1.6,
	damage = 3,
	reach = 2,
	fear_height = 4,
	pathfinding = 1,
	jump = true,
	jump_height = 4,
	group_attack = { "mobs_mc:zombie", "mobs_mc:baby_zombie", "mobs_mc:husk", "mobs_mc:baby_husk", "mobs_mc:bad_dog"},
	drops = drops_zombie,
	animation = {
		speed_normal = 25,		speed_run = 50,
		stand_start = 40,		stand_end = 80,
		walk_start = 0,		walk_end = 40,
		run_start = 0,		run_end = 40,
	},
	sunlight_damage = 0, --UV
	view_range = 16,
	attack_type = "dogfight",
}

mobs:register_mob("mobs_mc:bad_dog", bad_dog)

--jon removed

-- Spawning

mobs:spawn_specific("mobs_mc:bad_dog", mobs_mc.spawn.wolf, {"air"}, 0, minetest.LIGHT_MAX+1, 30, 9000, 20, mobs_mc.spawn_height.water+3, mobs_mc.spawn_height.overworld_max)

--jon removed

-- Spawn eggs
mobs:register_egg("mobs_mc:bad_dog", S("Zombie dog"), "mobs_mc_spawn_icon_wolf.png", 0)

if minetest.settings:get_bool("log_mods") then
	minetest.log("action", "MC Zombie dog loaded")
end
