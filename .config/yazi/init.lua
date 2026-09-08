-- Override the built-in `mtime` linemode to show "size  mtime" on one line.
-- Bound to `mm` and used as the startup default via `linemode = "mtime"` in yazi.toml.
-- API (yazi 26.x): self._file:size(), ya.readable_size(), self._file.cha.mtime (unix ts).
function Linemode:mtime()
	-- Size (files) or child count (directories, mirrors the preset `size` linemode)
	local size = self._file:size()
	local size_str
	if size then
		size_str = ya.readable_size(size)
	else
		local folder = cx.active:history(self._file.url)
		size_str = folder and tostring(#folder.files) or "-"
	end

	-- Modification time: fixed "YYYY-MM-DD HH:MM"
	local time = math.floor(self._file.cha.mtime or 0)
	local time_str = time == 0 and "" or os.date("%Y-%m-%d %H:%M", time)

	return string.format("%s  %s", size_str, time_str)
end

-- Override the built-in horizontal layout to drop panes on narrow terminals.
-- Wide = 3 panes (parent/current/preview), medium = 2 (current/preview), narrow = 1 (current).
-- Called on every redraw, so terminal resizes are reflected immediately.
function Tab:layout()
	local ratio = rt.mgr.ratio
	local w = self._area.w
	if w < 60 then
		ratio = { 0, 1, 0 }
	elseif w < 100 then
		ratio = { 0, ratio[2], ratio[3] }
	end

	local all = ratio[1] + ratio[2] + ratio[3]
	self._chunks = ui.Layout()
		:direction(ui.Layout.HORIZONTAL)
		:constraints({
			ui.Constraint.Ratio(ratio[1], all),
			ui.Constraint.Ratio(ratio[2], all),
			ui.Constraint.Ratio(ratio[3], all),
		})
		:split(self._area)
end
