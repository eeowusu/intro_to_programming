def number_to_word(x)
	units_dict = {
		"0" => "",
		"1" => "one",
		"2" => "two",
		"3" => "three",
		"4" => "four",
		"5" => "five",
		"6" => "six",
		"7" => "seven",
		"8" => "eight",
		"9" => "nine",	
	}

	tens_dict = {
		"0"  => "",
		"2" => "twenty",
		"3" => "thirty",
		"4" => "forty",
		"5" => "fifty",
		"6" => "sixty",
		"7" => "seventy",
		"8" => "eighty",
		"9" => "ninety",
	}

	one_tens_dict = {
		"10" => "ten",
		"11" => "eleven",
		"12" => "twelve",
		"13" => "thirteen",
		"14" => "fourteen",
		"15" => "fifteen",
		"16" => "sixteen",
		"17" => "seventeen",
		"18" => "eighteen",
		"19" => "nineteen",
	}

	x_length = x.length
	if x_length == 3
		hundreds = x[0]
		hundreds_in_words = units_dict[hundreds]
		if hundreds != "0"
			hundreds_in_words = hundreds_in_words + " hundred"
		end

		if x[1] == "1"
			words = hundreds_in_words + " and " + one_tens_dict[x[1..2]]
		elsif x[1] == "0"
			x[2] == "0" ? spacer = "" : spacer = " and "
			words = hundreds_in_words + spacer + units_dict [x[2]]
		else
			words = hundreds_in_words + " and " + tens_dict [x[1]] + " " + units_dict [x[2]]
		end

	elsif x_length == 2
		if x[0] == 0
			words = units_dict [x[1]]
		elsif x[0] == 1
			words = one_tens_dict[x]
		else words = tens_dict[x[0]] + " " + units_dict[x[1]]
		end

	elsif x_length == 1
		words = units_dict[x]
	else 
		words = "i don't know"
	end
end 

def translate(t)
    t = String t
    if t[0] == "-"
        t = t[1..-1]
        is_neg = true 
    else
        is_neg = false
    end

    t_array = t.split("")
    outer_array = []
    inner_array = []
    until t_array.length == 0 do
        popped = t_array.pop
        inner_array.unshift(popped)
        if inner_array.length == 3
            outer_array.unshift(inner_array.inject(""){|agg,i| agg+i})
            inner_array = []
        end
        if t_array.length == 0 and inner_array.length > 0
            outer_array.unshift(inner_array.inject(""){|agg,i| agg+i})
            inner_array = []
        end
    end

    length = outer_array.length
    billion_text = ""
    million_text = ""
    thousand_text = ""
    unit_text = ""
    if length == 4
        billion_text = number_to_word(outer_array[0]) + " billion"
        million_text = number_to_word(outer_array[1]) + " million"
        thousand_text = number_to_word(outer_array[2])
        thousand_text.strip.empty? ? thousand_text = thousand_text.strip : thousand_text = thousand_text.strip + " thousand"
        unit_text = number_to_word(outer_array[3])

        output = "#{billion_text}, #{million_text}, #{thousand_text}, #{unit_text}"
    elsif length == 3
        million_text = number_to_word(outer_array[0]) + " million"
        thousand_text = number_to_word(outer_array[1])
        thousand_text.strip.empty? ? thousand_text = thousand_text.strip : thousand_text = thousand_text.strip + " thousand"
        unit_text = number_to_word(outer_array[2])
        output = "#{million_text}, #{thousand_text}, #{unit_text}"
    elsif length == 2
        thousand_text = number_to_word(outer_array[0]) + " thousand"
        unit_text = number_to_word(outer_array[1])
        output = "#{thousand_text}, #{unit_text}"
    elsif length == 1
        unit_text = number_to_word(outer_array[0])
        output = "#{unit_text}"
    else
        output =  "something went wrong" 
    end

    if is_neg
        puts ("NEGATIVE " + output.upcase) 
    else
        puts output.upcase
    end
end

translate(4355364)
translate(-1009009)
translate(1111122980)
#puts three_nos_to_words("000")
# puts three_nos_to_words("190")
# puts three_nos_to_words("09")
# puts three_nos_to_words("122")

