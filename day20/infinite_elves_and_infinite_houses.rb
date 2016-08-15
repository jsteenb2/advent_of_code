require 'pry-byebug'
require 'prime'
require 'benchmark'
# elf 1 delivers presents every house, elf delivers 1 * 10 times to every house
# elf 2 delivers presents for every house % 2 = 0, every even, delivers 2 * 10 times to every house = 20
# elf 3 delivers presents for every house % 3 = 0, every three, delviers 3 * 10 times to every house = 30
# elf 4 delivers presents for every house % 4 = 0, every four, delivers 4 * 10 times to every house = 40
# elf 5 delivers presents for every house % 5 = 0. every five, delivers 5 * 10 times to every house = 50

# house 1 = 10 presents
# house 2 = 10 + 20 presents
# house 3 = 10 + 30 presents
# house 4 = 10 + 20 + 40 presents
# house 5 = 10 + 50 presents
# house 6 = 10 + 20 + 30 + 60 presents
# house 7 = 10 + 70 presents
# house 8 = 10 + 20 + 40 + 80 presents
# house 9 = 10 + 20 + 30 + 90 presents
# house 10 = 10 + 20 + 50 + 100 presents
# note: house 10 = 10 * ( 1 + 2 + 5 + 10 )
# pattern emerges => [all factors of number].inject(:+)
# pattern emerges =>  house total from house factors total(w/o house num itself)  + 10 * current_house_num

# What is the lowest house number that gets presents equal or greater than the input arg to the algorithm

# first attempt would be something like
def elf_house_present_counter(magic_num)
  magic_num /= 10
    return 'House #1' if magic_num < 11
    (2..magic_num).each do |house_num|
        house_factors_sum = house_num.factors_sum
        if house_factors_sum >= magic_num
            return "The House you are looking for is:  ##{house_num}\n" + "It has #{house_factors_sum} presents!"
        end
    end
end

# if house less than 11, then return house 1
# if not then find where we find house

# need to start at house 2, then find its factors and mult by 10
# if factor found in the cache then return the sum of the factors of that number
# iterate through each number until all factors are obtained
# will cache the answer to that

# def elf_house_present_counter(magic_num)
#   return 'House #1' if magic_num < 11
#   presents_to_house = {1 => 1, 2 => 3}
#                       #  3 => 4, 4 => 7,
#                       #  5 => 6}
#   house_num = 1
#   presents_total = 0
#   while presents_total * 10 < magic_num
#     house_num += 1
#     temp_num = house_num
#     presents_total = 0
#     divisor = 1
#     while divisor <= Math.sqrt(house_num) && temp_num > 1
#       binding.pry
#       divisor += 1
#       if presents_to_house.include?( temp_num )
#         presents_total += presents_to_house[temp_num]
#         presents_to_house[house_num] = presents_total
#         break
#       end
#       while temp_num % divisor == 0
#         if presents_to_house.include?( temp_num )
#           presents_total += presents_to_house[temp_num]
#           return house_num if presents_total * 10 >= magic_num
#           break
#         end
#         presents_total += divisor
#         temp_num /= divisor
#       end
#     end
#   end
#   house_num
# end

$presents_to_house = { 1 => 1}#, 2 => 3,
                      #  3 => 4, 4 => 7,
                      #  5 => 6 }

def factors_cache(n)
    return 1 if n == 1
    return n + 1 if n.prime?
    temp_num = n
    i = 1
    factors_sum = 0

    while temp_num > 1
      i += 1
        if $presents_to_house.include?(temp_num)
            factors_sum += $presents_to_house[temp_num] - 1
            break
        end

        while temp_num % i == 0
          # binding.pry
            factors_sum += temp_num
            temp_num /= i
            # if $presents_to_house.include?(temp_num)
            #     break_flag = true
            #     factors_sum += $presents_to_house[temp_num]
            #     break
            # end
        end
        # break if break_flag
    end
    # factors_sum += n
    factors_sum + 1
end

# n = 10
# puts factors_cache(n)

class Integer
    def factors_sum
        1.upto(Math.sqrt(self)).select { |i| (self % i).zero? }.inject(0) do |f, i|
            f += self / i unless i == self / i
            f += i
        end
    end

    # def factors_sum
    #     1.upto(Math.sqrt(self).to_i).inject(0) do |f, i|
    #       if (self % i).zero?
    #         f += self / i unless i == self / i
    #         f += i
    #       end
    #     end
    # end

    def factors
        1.upto(Math.sqrt(self)).select { |i| (self % i).zero? }.inject([]) do |f, i|
            f << self / i unless i == self / i
            f << i
        end.sort
    end
end

# puts n.factors_sum

# puts 4.factors_sum
# puts 5.factors_sum
# puts 7.factors_sum
# 36000000
# n = 36_000_000
n = 10_000_000
# puts "You are searching for the first house with at least #{n} presents"
time_start = Time.now
puts elf_house_present_counter(n)
puts "Time to run: #{Time.now - time_start}"

# Need to cache already calculated numbers
# puts elf_house_present_counter(71)
