module Day14
  module Part1

    def self.run(input)
      recipes = {}

      input.each_line do |line|
        recipe = line.scan(/(\d+) (\w+)/)
        recipe.map! { |i| { amount: i[0].to_i, type: i[1] } }
        inputs = recipe[0...-1]
        output = recipe[-1]
        recipes[output[:type]] = { output_amount: output[:amount], inputs: inputs }
      end
      warehouse = {}
      return self.ore_required("FUEL", 1, recipes, warehouse)
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

