---@diagnostic disable: undefined-global

AddCSLuaFile()

assert(
	CLIENT or SERVER,
	"Invalid execution context. This file should be executed on the server or the client."
)

game.AddParticles("particles/hl2mmod_burning_fx.pcf")
PrecacheParticleSystem("burning_character")
