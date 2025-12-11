-- Desactivar Animaciones de Scroll en Neovim
-- Las animaciones de scroll pueden ser molestas para algunos usuarios
-- Este archivo las desactiva completamente

return {
	"folke/snacks.nvim",
	opts = {
		scroll = {
			enabled = false, -- Desactivar animaciones de scroll
		},
	},
}
