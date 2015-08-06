require "csv"

# seed the stock_infos table

# stock_info csvs as downloaded from http://www.nasdaq.com/screening/company­list.aspx

stock_list_dir = "db/stocklists/"
stock_info_csv_files = `ls #{stock_list_dir}`.split

# uncomment following to rebuild entire table - otherwise we update existing
# Stock.delete_all

stock_info_csv_files.each do |file|

  puts "processing #{file}"

  colnames = []

  CSV.foreach(stock_list_dir + file) do |row|

    # first line process as colnames (ie. column names)
    if (colnames.size == 0)
      colnames = row
      # rename columns or nil if we don't want it
      colnames.map! do |cname|
        if (cname == "Symbol")
          "symbol"
        elsif (cname == "Name")
          "name"
        else
          nil
        end
      end
    else # process rows
      rowentry = {}
      colnames.each_with_index { |col,index|
        next if col == nil
        rowentry[col] = row[index]
      }
      stock = Stock.where("symbol = ?", rowentry["symbol"]).take
      if stock
        stock.update(rowentry)
      else
        Stock.create(rowentry)
      end
    end
  end

end





