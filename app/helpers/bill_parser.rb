	module BillConverter

		def parse_bill
			bill_source = APP_ROOT.to_path+'/public/uploads/'+params[:bill][:name]

			File.open('public/uploads/'+params[:bill][:name], "w") do |f|
				f.write(params[:bill][:tempfile].read)
			end

			bill_data = read_csv(bill_source)

			bill_data.map! do |row|
				reformat_csv_row(row)
			end

		end

		def read_csv(source)
			bill_row = []
			CSV.foreach(source) do |row|
			 bill_row << row
			end
			bill_row
		end

		def reformat_csv_row(row)
			fields = [:user_id, :issue_date, :description, :amount, :action]
			row = Hash[fields.zip(row)]
			replace_handle_by_id(row)
		end

		def replace_handle_by_id(row)
			user_id = User.find_by(handle: row[:user_id]).id
			row[:user_id] = user_id
			row
		end

	end

helpers BillConverter