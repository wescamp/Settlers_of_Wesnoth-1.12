sow_constants = {}

if not wesnoth then
	package.path = package.path .. ";../../../../../data/lua/?.lua"
	wesnoth = require("wesnoth")
end
local _ = wesnoth.textdomain("wesnoth-Settlers_of_Wesnoth")
local helper = wesnoth.require("lua/helper.lua")

sow_constants.MAX_UNSIGNED = 2147483647 --on my system...

sow_constants.halfing_limit = 7
max_trade_offers = 3
resource_letter = { ["Gs^Fds"] = "lumber", ["Gg"] = "wool", ["Gd"] = "grain", ["Hhd"] = "brick", ["Mm"] = "ore" }
resource_terrains = ""
for k, v in pairs(resource_letter) do
	resource_terrains = string.format("%s%s,", resource_terrains, k)
end
resource_terrains:sub(1, resource_terrains:len() - 1)
translatable_resources = { lumber = _"lumber", grain = _"grain", wool = _"wool", brick = _"brick", ore = _"ore" }

-- Coords for labels
-- x= is coordinate for the column with resources etc
sow_constants.sow_labels_new =
{
	name = 1,
	players =
	{
		{ name = _"Red", x = 4, color = "#ff0000" },
		{ name = _"Blue", x = 6, color = "#0000ff" },
		{ name = _"Green", x = 8, color = "#00ff00" },
		{ name = _"Purple", x = 10, color = "#ff00ff" },
		{ name = _"Black", x = 12, color = "#505050" },
		{ name = _"Brown", x = 14, color = "#993400" },
		{ name = _"Orange", x = 16, color = "#FF9900" },
		{ name = _"Teal", x = 18, color = "#00FFB4" },
		{ name = _"White", x = 2, color = "#FFFFFF" }
	},
	resources =
	{
		lumber = 12,
		grain = 13,
		wool = 14,
		brick = 15,
		ore = 16,
		resources = 7
	},
	development =
	{
		knight = 17,
		monopoly = 18,
		plenty = 19,
		road = 20,
		victory = 21,
		development = 8
	},
	victory =
	{
		road = 9,
		knight = 10,
		victory = 6
	}
}

local function retrieve_team_colors()
	local team_colors = wesnoth.get_variable("sow_team_colors")
	for i, v in ipairs(sow_constants.sow_labels_new.players) do
		local color = wesnoth.sides[i].color
		local color_number = tonumber(color)
		if color_number then color = color_number end
		local rgb= helper.get_child(team_colors, "color_range", color).rgb
		v.color = "#" .. string.sub(rgb, 1, 6)
	end
end
retrieve_team_colors()

-- Map Attributes

sow_maps = {
	--resource tile := a numbered hex surrounded by six resource hexes
	--resources: (numbers, types of) resource tiles to create
	--numbers: (numbers, types of) the central numbers of the resource tiles to create
	--ports: (numbers, types of) port hexes to create
	--dev_deck: (numbers, types of) development cards available
	a = {
		ressources = {"Dd", "Gs^Fds", "Gs^Fds", "Gs^Fds", "Gg", "Gg", "Gg", "Gd", "Gd", "Gd", "Mm", "Mm", "Mm", "Hhd", "Hhd", "Hhd"},
		numbers = {"Re^Ye","Re^Ye","Re^Yf","Re^Yf","Re^Ya","Re^Yb","Re^Yc","Re^Yd","Re^Yd","Re^Yg","Re^Yg","Re^Yh","Re^Yh","Re^Yi","Re^Yj"},
		ports = {"lumber","grain","wool","brick","ore","any","any","any"},
		dev_deck = {victory=5,monopoly=2,road=2,plenty=2,knight=14}
	},
	b = {
		ressources = {"Dd", "Gs^Fds", "Gs^Fds", "Gs^Fds", "Gs^Fds", "Gg", "Gg", "Gg", "Gd", "Gd", "Gd", "Gd", "Mm", "Mm", "Mm", "Hhd", "Hhd", "Hhd"},
		numbers = {"Re^Ye","Re^Ye","Re^Yf","Re^Yf","Re^Ya","Re^Yb","Re^Yc","Re^Yc","Re^Yd","Re^Yd","Re^Yg","Re^Yg","Re^Yh","Re^Yh","Re^Yi","Re^Yi","Re^Yj"},
		ports = {"lumber","grain","wool","brick","ore","any","any","any"},
		dev_deck = {victory=5,monopoly=2,road=2,plenty=2,knight=14}
	},
	c = {
		ressources = {"Dd", "Gs^Fds", "Gs^Fds", "Gs^Fds", "Gs^Fds", "Gg", "Gg", "Gg", "Gg", "Gd", "Gd", "Gd", "Gd", "Mm", "Mm", "Mm", "Hhd", "Hhd", "Hhd"},
		numbers = {"Re^Ye","Re^Ye","Re^Yf","Re^Yf","Re^Ya","Re^Yb","Re^Yb","Re^Yc","Re^Yc","Re^Yd","Re^Yd","Re^Yg","Re^Yg","Re^Yh","Re^Yh","Re^Yi","Re^Yi","Re^Yj"},
		ports = {"lumber","grain","wool","brick","ore","any","any","any","any"},
		dev_deck = {victory=5,monopoly=2,road=2,plenty=2,knight=14}
	},
	d = {
		ressources = {"Dd", "Gs^Fds", "Gs^Fds", "Gs^Fds", "Gs^Fds", "Gg", "Gg", "Gg", "Gg", "Gd", "Gd", "Gd", "Gd", "Mm", "Mm", "Mm", "Mm", "Hhd", "Hhd", "Hhd", "Hhd"},
		numbers = {"Re^Ye","Re^Ye","Re^Yf","Re^Yf","Re^Ya","Re^Ya","Re^Yb","Re^Yb","Re^Yc","Re^Yc","Re^Yd","Re^Yd","Re^Yg","Re^Yg","Re^Yh","Re^Yh","Re^Yi","Re^Yi","Re^Yj","Re^Yj"},
		ports = {"lumber","lumber","grain","wool","brick","ore","any","any","any","any"},
		dev_deck = {victory=5,monopoly=2,road=2,plenty=2,knight=14}
	},
	e = {
		ressources = {"Dd", "Gs^Fds","Gs^Fds", "Gs^Fds", "Gs^Fds", "Gs^Fds", "Gg","Gg", "Gg", "Gg", "Gg", "Gd", "Gd", "Gd", "Gd", "Gd", "Mm", "Mm","Mm", "Mm", "Hhd","Hhd", "Hhd", "Hhd"},
		numbers = {"Re^Ye","Re^Ye","Re^Ye","Re^Yf","Re^Yf","Re^Yf","Re^Ya","Re^Ya","Re^Yb","Re^Yb","Re^Yc","Re^Yc","Re^Yd","Re^Yd","Re^Yd","Re^Yg","Re^Yg","Re^Yh","Re^Yh","Re^Yi","Re^Yi","Re^Yj","Re^Yj"},
		ports = {"lumber","wool","grain","wool","brick","ore","any","any","any","any"},
		dev_deck = {victory=8,monopoly=3,road=3,plenty=3,knight=21}
	},
	f = {
		ressources = {"Dd", "Dd", "Gs^Fds", "Gs^Fds","Gs^Fds", "Gs^Fds", "Gs^Fds", "Gs^Fds", "Gg", "Gg","Gg", "Gg", "Gg", "Gg", "Gd", "Gd","Gd", "Gd", "Gd", "Gd", "Mm", "Mm","Mm", "Mm", "Mm", "Hhd", "Hhd","Hhd", "Hhd", "Hhd"},
		numbers = {"Re^Ye","Re^Ye","Re^Ye","Re^Yf","Re^Yf","Re^Yf","Re^Ya","Re^Ya","Re^Yb","Re^Yb","Re^Yb","Re^Yc","Re^Yc","Re^Yc","Re^Yd","Re^Yd","Re^Yd","Re^Yg","Re^Yg","Re^Yg","Re^Yh","Re^Yh","Re^Yh","Re^Yi","Re^Yi","Re^Yi","Re^Yj","Re^Yj"},
		ports = {"lumber","lumber","grain","wool","brick","ore","brick","any","any","any","any"},
		dev_deck = {victory=8,monopoly=3,road=3,plenty=3,knight=21}
	},
	g = {
		ressources = {"Dd", "Dd", "Gs^Fds", "Gs^Fds","Gs^Fds", "Gs^Fds", "Gs^Fds", "Gg","Gg", "Gg", "Gg", "Gg", "Gd", "Gd","Gd", "Gd", "Gd", "Gd", "Mm", "Mm","Mm", "Mm", "Mm", "Hhd", "Hhd","Hhd", "Hhd", "Hhd"},
		numbers = {"Re^Ye","Re^Ye","Re^Ye","Re^Yf","Re^Yf","Re^Yf","Re^Ya","Re^Ya","Re^Yb","Re^Yb","Re^Yc","Re^Yc","Re^Yc","Re^Yd","Re^Yd","Re^Yd","Re^Yg","Re^Yg","Re^Yg","Re^Yh","Re^Yh","Re^Yh","Re^Yi","Re^Yi","Re^Yj","Re^Yj"},
		ports = {"lumber","grain","grain","wool","brick","ore","any","any","any","any","any"},
		dev_deck = {victory=8,monopoly=3,road=3,plenty=3,knight=21}
	},
	h = {
		ressources = {"Dd", "Dd", "Gs^Fds", "Gs^Fds","Gs^Fds", "Gs^Fds", "Gs^Fds", "Gs^Fds", "Gg","Gg", "Gg", "Gg", "Gg", "Gd","Gd", "Gd", "Gd", "Gd", "Mm", "Mm","Mm", "Mm", "Mm", "Hhd", "Hhd","Hhd", "Hhd", "Hhd"},
		numbers = {"Re^Ye","Re^Ye","Re^Ye","Re^Yf","Re^Yf","Re^Yf","Re^Ya","Re^Ya","Re^Yb","Re^Yb","Re^Yc","Re^Yc","Re^Yc","Re^Yd","Re^Yd","Re^Yd","Re^Yg","Re^Yg","Re^Yg","Re^Yh","Re^Yh","Re^Yh","Re^Yi","Re^Yi","Re^Yj","Re^Yj"},
		ports = {"lumber","grain","wool","lumber","grain","wool","brick","ore","any","any","any","any"},
		dev_deck = {victory=8,monopoly=3,road=3,plenty=3,knight=21}
	},
	i = {
		ressources = {"Dd", "Dd", "Gs^Fds", "Gs^Fds","Gs^Fds", "Gs^Fds", "Gs^Fds", "Gs^Fds", "Gg", "Gg","Gg", "Gg", "Gg", "Gg", "Gd", "Gd","Gd", "Gd", "Gd", "Gd", "Mm", "Mm","Mm", "Mm", "Mm", "Hhd", "Hhd","Hhd", "Hhd", "Hhd"},
		numbers = {"Re^Ye","Re^Ye","Re^Ye","Re^Yf","Re^Yf","Re^Yf","Re^Ya","Re^Ya","Re^Yb","Re^Yb","Re^Yb","Re^Yc","Re^Yc","Re^Yc","Re^Yd","Re^Yd","Re^Yd","Re^Yg","Re^Yg","Re^Yg","Re^Yh","Re^Yh","Re^Yh","Re^Yi","Re^Yi","Re^Yi","Re^Yj","Re^Yj"},
		ports = {"lumber","grain","wool","brick","ore","any","any","any","any","any","any"},
		dev_deck = {victory=8,monopoly=3,road=3,plenty=3,knight=21}
	},
	j = {
		ressources = {"Dd", "Gs^Fds", "Gs^Fds", "Gs^Fds", "Gg", "Gg", "Gg", "Gd", "Gd", "Mm", "Mm", "Hhd", "Hhd", "Dd", "Gs^Fds", "Gs^Fds", "Gs^Fds", "Gs^Fds", "Gg", "Gg", "Gg", "Gg", "Gd", "Gd", "Gd", "Gd", "Mm", "Mm", "Mm", "Hhd", "Hhd", "Hhd"},
		numbers = {"Re^Ye","Re^Ye","Re^Yf","Re^Yf","Re^Ye","Re^Ye","Re^Yf","Re^Yf","Re^Yb","Re^Yc","Re^Yd","Re^Yd","Re^Yg","Re^Yg","Re^Yh","Re^Yh","Re^Yi","Re^Yi","Re^Yj","Re^Ya","Re^Yb","Re^Yb","Re^Yc","Re^Yc","Re^Yd","Re^Yd","Re^Yg","Re^Yg","Re^Yh","Re^Yi"},
		ports = {"lumber","grain","wool","lumber","grain","wool","brick","ore","any","any","any","any"},
		dev_deck = {victory=10,monopoly=4,road=4,plenty=4,knight=28}
	},
	k = {
		ressources = {"Dd", "Gs^Fds", "Gs^Fds", "Gs^Fds", "Gs^Fds", "Gg", "Gg", "Gg", "Gd", "Gd", "Gd", "Mm", "Mm", "Mm", "Hhd", "Hhd", "Hhd", "Dd", "Gs^Fds", "Gs^Fds", "Gs^Fds", "Gs^Fds", "Gg", "Gg", "Gg", "Gg", "Gd", "Gd", "Gd", "Gd", "Mm", "Mm", "Mm", "Hhd", "Hhd", "Hhd"},
		numbers = {"Re^Ye","Re^Ye","Re^Yf","Re^Yf","Re^Ye","Re^Ye","Re^Yf","Re^Yf","Re^Ya","Re^Yb","Re^Yc","Re^Yc","Re^Yd","Re^Yd","Re^Yg","Re^Yg","Re^Yh","Re^Yh","Re^Yi","Re^Yi","Re^Yj","Re^Ya","Re^Yb","Re^Yb","Re^Yc","Re^Yc","Re^Yd","Re^Yd","Re^Yg","Re^Yg","Re^Yh","Re^Yh","Re^Yi","Re^Yj"},
		ports = {"grain","wool","lumber","grain","wool","brick","ore","any","any","any","any","any"},
		dev_deck = {victory=10,monopoly=4,road=4,plenty=4,knight=28}
	},
	l = {
		ressources = {"Dd", "Gs^Fds", "Gs^Fds", "Gs^Fds", "Gs^Fds", "Gg", "Gg", "Gg", "Gg", "Gd", "Gd", "Gd", "Gd", "Mm", "Mm", "Mm", "Hhd", "Hhd", "Hhd", "Dd", "Gs^Fds", "Gs^Fds", "Gs^Fds", "Gs^Fds", "Gg", "Gg", "Gg", "Gg", "Gd", "Gd", "Gd", "Gd", "Mm", "Mm", "Mm", "Hhd", "Hhd", "Hhd"},
		numbers = {"Re^Ye","Re^Ye","Re^Yf","Re^Yf","Re^Ye","Re^Ye","Re^Yf","Re^Yf","Re^Ya","Re^Yb","Re^Yb","Re^Yc","Re^Yc","Re^Yd","Re^Yd","Re^Yg","Re^Yg","Re^Yh","Re^Yh","Re^Yi","Re^Yi","Re^Yj","Re^Ya","Re^Yb","Re^Yb","Re^Yc","Re^Yc","Re^Yd","Re^Yd","Re^Yg","Re^Yg","Re^Yh","Re^Yh","Re^Yi","Re^Yi","Re^Yj"},
		ports = {"lumber","grain","wool","lumber","grain","wool","brick","ore","any","any","any","any","any","any"},
		dev_deck = {victory=10,monopoly=4,road=4,plenty=4,knight=28}
	},
	m = {
		ressources = {"Dd", "Gs^Fds", "Gs^Fds", "Gs^Fds", "Gs^Fds", "Gg", "Gg", "Gg", "Gg", "Gd", "Gd", "Gd", "Gd", "Mm", "Mm", "Mm", "Hhd", "Hhd", "Hhd", "Dd", "Gs^Fds", "Gs^Fds", "Gs^Fds", "Gg", "Gg", "Gg", "Gg", "Gd", "Gd", "Gd", "Gd", "Mm", "Mm", "Mm", "Hhd", "Hhd", "Hhd"},
		numbers = {"Re^Ye","Re^Ye","Re^Yf","Re^Yf","Re^Ye","Re^Ye","Re^Yf","Re^Yf","Re^Ya","Re^Yb","Re^Yb","Re^Yc","Re^Yc","Re^Yd","Re^Yd","Re^Yg","Re^Yg","Re^Yh","Re^Yh","Re^Yi","Re^Yi","Re^Yj","Re^Ya","Re^Yb","Re^Yb","Re^Yc","Re^Yc","Re^Yd","Re^Yd","Re^Yg","Re^Yg","Re^Yh","Re^Yh","Re^Yi","Re^Yj"},
		ports = {"lumber","grain","wool","brick","ore","brick","ore","any","any","any","any","any"},
		dev_deck = {victory=10,monopoly=4,road=4,plenty=4,knight=28}
	},
}

