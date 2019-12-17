module Day14
  module Part2

    def self.run(input)
      recipes = {}

      input.each_line do |line|
        recipe = line.scan(/(\d+) (\w+)/)
        recipe.map! { |i| { amount: i[0].to_i, type: i[1] } }
        inputs = recipe[0...-1]
        output = recipe[-1]
        recipes[output[:type]] = { output_amount: output[:amount], inputs: inputs }
      end

      ore_amount = 1000000000000
      fuel_to_make = 0
      fuel_to_make_more = 1000000000000

      until fuel_to_make_more == 1
        fuel_to_make_more /= 10
        required_ore = 0
        while required_ore < ore_amount
          warehouse = {}
          fuel_to_make += fuel_to_make_more
          required_ore = self.ore_required("FUEL", fuel_to_make, recipes, warehouse)
        end

        fuel_to_make -= fuel_to_make_more
      end

      return fuel_to_make
    end

    private

    def self.ore_required(output, required_amount, recipes, warehouse)
      if output == "ORE"
        return required_amount
      end
      left = (warehouse[output] || 0) - required_amount

      if left < 0
        warehouse[output] = 0
        recipe = recipes[output]
        recipe_amount = ((left / -1).to_f / recipe[:output_amount]).ceil
        amount_to_make = recipe_amount * recipe[:output_amount]
        amount_overmade = amount_to_make - (left / -1)
        ore_amount = 0
        recipe[:inputs].each do |input|
          ore_amount += self.ore_required(input[:type], input[:amount] * recipe_amount, recipes, warehouse)
        end
        warehouse[output] = amount_overmade
        return ore_amount
      else
        warehouse[output] -= required_amount
        return 0
      end

    end


  end
end

