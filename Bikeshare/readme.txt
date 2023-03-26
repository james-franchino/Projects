This was a challenging first project and required a lot of trial, error, and googling on my part. I have done my best to document every source for everything I did not learm directly from Udacity below:

Use .value_counts came from https://www.marsja.se/pandas-count-occurrences-in-column-unique-values/ which I found on July 02, 2022
Use of .mode()[0] came from Udacity project practice problem 1 and corresponding documentation on July 01, 2022
Use of DataFrame.iloc came from code reviewers suggestion and from https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.iloc.html on July 02, 2022
Use of pandas.Series.dt.month and pandas.Series.dt.day came from code reviewers suggestion and from https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.Series.dt.month.html and https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.Series.dt.day.html
Use of try/accept suggested by Udacity code reviewer and https://www.w3schools.com/python/python_try_except.asp
Additionally the code block:
 if month != 'all':
        months = ['January', 'February', 'March', 'April', 'May', 'June']
        month = months.index(month) + 1

        # filter by month to create the new dataframe
        df = df[df['month'] == month]
was provided by Udacity code reviewers 

and the basis for the code block:
view_data = input('\nWould you like to view 5 rows of individual trip data? Enter yes or no\n')
start_loc = 0
while (?????):
  print(df.iloc[????:????])
  start_loc += 5
  view_data = input("Do you wish to continue?: ").lower()
Was provided by Udacity code reviewer and completed by me

Use of .str.startswith came from https://docs.python.org/3/library/stdtypes.html#str.startswith and https://www.tutorialspoint.com/python/string_startswith.htm and https://stackoverflow.com/questions/27275236/how-to-select-all-columns-whose-names-start-with-x-in-a-pandas-dataframe