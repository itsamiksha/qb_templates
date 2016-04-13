class QuestionTemplate < ActiveRecord::Base

@constraints = <<"EOF"
  @k1 = rand(10...20);
  @k2 = rand(1...10);
  @k3 = 10*rand(1..3);
EOF

@values = <<"EOF"
  @cost_prices = [100*@k1];
  @expenses = [100*@k2];
  @selling_prices = [(@k1+@k2)*(@k3+100)];
EOF

@template = nil
@equation = nil

  def self.init
    constraint
  end

  def self.constraint
    @constraints.squish.split(";").map{|c| eval(c)}
    values
  end

  def self.values
    @values.squish.split(";").map{|v| eval(v)}
    puts "@cost_prices = #{@cost_prices}"
    puts "@expenses = #{@expenses}"
    puts "@selling_prices = #{@selling_prices}"

    set_template
    set_eqaution

    puts @template.squish
    puts eval @equation

  end

  def self.set_template
    @template = <<"EOF"
        The cost price of an article is #{@cost_prices[0]} and expense on it is #{@expenses[0]}. If selling price is #{@selling_prices[0]}. Find profit/gain percentage.
EOF
  end

  def self.set_eqaution
    @equation = <<"EOF"
    (#{@selling_prices[0]}-(#{@cost_prices[0]}+#{@expenses[0]}))*100/(#{@cost_prices[0]}+#{@expenses[0]})
EOF
  end

end
