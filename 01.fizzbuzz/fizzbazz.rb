(1..20).each do |num|
  if num % 3 == 0 && num % 5 == 0
    puts "FizzBazz"
  elsif num % 3 == 0
    puts "Fizz"
  elsif num % 5 == 0
    puts "Bazz"
  else
    puts num
  end
end
