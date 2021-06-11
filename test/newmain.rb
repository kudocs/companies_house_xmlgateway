
company = Company.where(company_number: '01744553').first
company_header = { 
        number: '01744553',
        type: 'EW',
        name: 'Chelsea Property Company',
        auth_code: 'E31281',
        contact_name: 'Matt Clover',
        contact_number: '07412688953'
      }
      
company_data_form = { number: '01744553', auth_code: 'E31281'}