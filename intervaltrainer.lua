m = midi.connect()

function init()
  for i = 1,12 do
    generate_an_interval()
  end
end

all_intervals = {1,2,3,4,5,6,7,8,9,10,11}
current_interval_table = {}

display_intervals = {}
display_intervals[1]  = " 1, -11"
display_intervals[2]  = " 2, -10"
display_intervals[3]  = " 3, - 9"
display_intervals[4]  = " 4, - 8"
display_intervals[5]  = " 5, - 7"
display_intervals[6]  = " 6, - 6"
display_intervals[7]  = " 7, - 5"
display_intervals[8]  = " 8, - 4"
display_intervals[9]  = " 9, - 3"
display_intervals[10] = "10, - 2"
display_intervals[11] = "11, - 1"
 
for i = 1,11 do
  current_interval_table[i] = all_intervals[i]
end

next_interval = 0

function generate_an_interval()
  if tablelength(current_interval_table) == 0 then
    for i =1,11 do
      current_interval_table[i] = all_intervals[i]
    end
  end
  local interval_picker = math.random(1, tablelength(current_interval_table))
  next_interval = current_interval_table[interval_picker]
  table.remove(current_interval_table, interval_picker)
  print(next_interval)
  redraw()
end

function redraw()
  
  screen.clear()
  screen.stroke()
 
  screen.move(0,40)
  screen.font_size(34)
  screen.text(display_intervals[next_interval])
  screen.update()
end

m.event = function(data)
    local d = midi.to_msg(data)
    if d.type == "note_on" then
      generate_an_interval()
    end
end

function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end
