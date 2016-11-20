defmodule Identicon do
	@moduledoc """
	Will create an identicon for given string.
	"""

	@doc """
	Returns an identicon for given image.
	"""
	def main(input) do
		input
		|> hash_input
		|> pick_colour
		|> build_grid
		|> filter_grid
		|> build_pixel_map
		|> draw_image
		|> save_image(input)
	end

	@doc """
	Returns an MD5 hash based on given input.
	"""
	def hash_input(input) do
		hex = :crypto.hash(:md5, input)
		|> :binary.bin_to_list

		%Identicon.Image{hex: hex}
	end

	@doc """
	Creates an RGB value from a given hex.
	"""
	def pick_colour(%Identicon.Image{hex: [r, g, b | _tail]} = image) do
		%Identicon.Image{image | colour: {r, g , b}}
	end

	@doc """
	Takes hex list, chunks into lists of 3, and mirrors each row.
	"""
	def build_grid(%Identicon.Image{hex: hex} = image) do
	 	grid =
			hex
			|> Enum.chunk(3)
			|> Enum.map(&mirror_row/1)
			|> List.flatten
			|> Enum.with_index

		%Identicon.Image{image | grid: grid}
	end

	@doc """
	Filters the grid list for even values to fill with colour
	"""
	def filter_grid(%Identicon.Image{grid: grid} = image) do
		grid = Enum.filter(grid, fn({code, _index}) -> rem(code, 2) == 0 end)

		%Identicon.Image{ image | grid: grid}
	end

	@doc """
	Builds a pixel map of (x,y) values to draw the identicon.
	"""
	def build_pixel_map(%Identicon.Image{grid: grid} = image) do
		pixel_map = Enum.map grid, fn({_code, index}) ->
			horizontal = rem(index, 5) * 50
			vertical = div(index, 5) * 50

			top_left = {horizontal, vertical}
			bottom_right = {horizontal + 50, vertical + 50}

			{top_left, bottom_right}
		end

		%Identicon.Image{image | pixel_map: pixel_map}
	end

	@doc """
	Takes the pixel map and draws the grid of rectangles.
	"""
	def draw_image(%Identicon.Image{colour: colour, pixel_map: pixel_map}) do
		image = :egd.create(250, 250)
		fill = :egd.color(colour)

		Enum.each pixel_map, fn({start, stop}) ->
			:egd.filledRectangle(image, start, stop, fill)
		end

		:egd.render(image)
	end

	def save_image(image, input) do
		File.write("#{input}.png", image)
	end

	@doc """
	Mirrors a given list.
	"""
	def mirror_row(row) do
		[first, second | _tail] = row
		row ++ [second, first]
	end

end
