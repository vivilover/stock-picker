=begin
  * Gameplan:
  Tips:
    1) You need to buy before you sell.
    2) Edge cases: lowest day is the last day or the highest day is the first day
    [17, 3, 6, 9, 15, 6, 1, 10]
      - We CANNOT sell on the first day (index 0). Default sell_day = stock_price[1]
      - We CAN buy on the first day, but we CANNOT sell on the last day.
        - When are we going to sell?
  -Going for the "maximum margin"
    - say I buy when the price is "1" (index 6)
    - trying to sell it when the price is the highest "17"
    - need to keep track of the margin
      - margin: stock_prices[sell_day] - stock_prices[buy_day]
      - before updating buy_day, make sure updating it will lead to increased margin
        - but HOW?
        - for each element, use ITERATION
          - calculate hypothetical margin
          - if margin at the specific element is bigger than the current margin, update
            - Otherwise, leave it as it is.
      - before updating sell_day, make sure updating it will lead to increased margin
=end
=begin
    * Pseudocode
    1. initialize variables: buy_day, sell_day, transaction_days
    2. Iterate through stock_prices, one element at a time using #each_with_index
       2.1 Iterate from the next index to the end, calculate margin
       Challenge) How to iterate inside of an array
            for i in 0..arr.length-1
              k = i + 1
              for k in k..arr.length-1
                do stuff
              end
            end

       2.2 If the new margin is bigger than the current margin, update buy_day or sell_day
    3. When iteration is done, push buy_day and sell_day to transaction_days
=end
def stock_picker(stock_prices)
  # initialize variables: buy_day, sell_day, transaction_days, margin
  buy_day_index = 0
  sell_day_index = 1
  transaction_days = []
  margin = 0 # stock_price[sell_day_index] - stock_price[buy_day_index]
  # nested loop to iterate through "stock_prices" and update buy_day_index and sell_day_index if it
  # gives greater margin
  for i in 0..stock_prices.length-2 # outer loop
    j = i + 1
    for j in j..stock_prices.length-1 # inner loop
      temp_buy_index = i
      temp_sell_index = j
      temp_margin = stock_prices[temp_sell_index] - stock_prices[temp_buy_index]
      if temp_margin > margin
        sell_day_index = temp_sell_index
        buy_day_index = temp_buy_index
        margin = stock_prices[sell_day_index] - stock_prices[buy_day_index]
      end
    end
  end
  transaction_days.push(buy_day_index, sell_day_index)
end

p stock_picker([17,3,6,9,15,8,6,1,10])
# => [1, 4]