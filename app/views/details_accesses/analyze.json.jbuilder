counter = 0
json.series @data do |column|
    counter += 1
    json.name counter
    json.data column
end