---@diagnostic disable: undefined-global

AddCSLuaFile()

assert(
	CLIENT or SERVER,
	"Invalid execution context. This file should be executed on the server or the client."
)

game.AddParticles("particles/hl2mmod_envfire.pcf")

local env_fire = {
	"env_fire_large",
	"env_fire_medium",
	"env_fire_small",
	"env_fire_tiny",
}

for _, v in pairs(env_fire) do
	PrecacheParticleSystem(v)
end
