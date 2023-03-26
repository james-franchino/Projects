import time
import pandas as pd
import numpy as np

# Load the dataset by global variable
CITY_DATA = {'chi': 'chicago.csv',
             'nyc': 'new_york_city.csv',
             'wsh': 'washington.csv'}


def get_filters():
    """
        Asks user to specify a city, month, and day to analyze.

        Returns:
            (str) city - name of the city to analyze
            (str) month - name of the month to filter by, or "all" to apply no month filter
            (str) day - name of the day of week to filter by, or "all" to apply no day filter
        """
    print('Today we\'re going to look at US bikeshare data!')
    # get user input for city (chicago, new york city, washington). HINT: Use a while loop to handle invalid inputs
    while True:
        city = input(
            "Please type one of the following cities: nyc for new york city, chi for chicago, "
            "or wsh for washington:\n").lower()
        if city in CITY_DATA.keys():
            break
        else:
            print("I don\'t see that city. Please try again")


# get user input for month (all, january, february, ... , june)
    months = ["january", "february", "march", "april", "may", "june", "all"]
    while True:
        month = input("Please pick a month: January, February, March, April, May, June, or all to see all "
                      "data:\n").lower()
        if month in months:
            break
        else:
            print("I don\'t see that month. Please try again")

    # get user input for day of week (all, monday, tuesday, ... sunday)
    days = ["monday", "tuesday", "wednesday", "thursday", "friday", "saturday", "sunday", "all"]
    while True:
        day = input("Please pick a day (Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday, or all to see "
                    "all data:\n").lower()
        if day in days:
            break
        else:
            print("I don\'t see that day. Please try again")

    print('-'*40)
    return city, month, day


def load_data(city, month, day):

    """
    Loads data for the specified city and filters by month and day if applicable.

    Args:
        (str) city - name of the city to analyze
        (str) month - name of the month to filter by, or "all" to apply no month filter
        (str) day - name of the day of week to filter by, or "all" to apply no day filter
    Returns:
        df - Pandas DataFrame containing city data filtered by month and day
    """
    df = pd.read_csv(CITY_DATA[city])
    df['Start Time'] = pd.to_datetime(df['Start Time'])
    df['month'] = df['Start Time'].dt.month_name()
    df['day_of_week'] = df['Start Time'].dt.day_name()

    if month != 'all':
        df = df[df['month'].str.startswith(month.title())]

    if day != 'all':
        df = df[df['day_of_week'].str.startswith(day.title())]
    return df


def time_stats(df):
    """Displays statistics on the most frequent times of travel."""

    print('\nCalculating The Most Frequent Times of Travel...\n')
    start_time = time.time()

    # display the most common month
    df['month'] = df['Start Time'].dt.month_name()
    most_common_month = df['month'].mode()[0]
    print("Most common month is ", most_common_month)

    # display the most common day of week
    df['day_of_week'] = df['Start Time'].dt.day_name()
    most_common_day = df['day_of_week'].mode()[0]
    print('The most common day is ', most_common_day)

    # display the most common start hour
    df['hour'] = df['Start Time'].dt.hour
    most_common_hour = df['hour'].mode()[0]
    print('The most common hour is ', most_common_hour)

    print("\nThis took %s seconds." % (time.time() - start_time))
    print('-'*40)


def station_stats(df):
    """Displays statistics on the most popular stations and trip."""

    print('\nCalculating The Most Popular Stations and Trip...\n')
    start_time = time.time()

    # display most commonly used start station
    most_start = df['Start Station'].mode()[0]
    print("The most common start station is:", most_start)

    # display most commonly used end station
    most_end = df['End Station'].mode()[0]
    print("The most common end station is:", most_end)

    # display most frequent combination of start station and end station trip
    common_combo = 'from' + df['Start Station'].mode()[0] + ' to ' + df['End Station'].mode()[0]
    print("Most frequent combination is:", common_combo)

    print("\nThis took %s seconds." % (time.time() - start_time))
    print('-'*40)


def trip_duration_stats(df):
    """Displays statistics on the total and average trip duration."""

    print('\nCalculating Trip Duration...\n')
    start_time = time.time()

    # display total travel time
    total_trip = df['Trip Duration'].sum()
    print("The total trip duration is:", total_trip)

    # display mean travel time
    average_time = df['Trip Duration'].mean()
    print("The average trip time was:", average_time)

    print("\nThis took %s seconds." % (time.time() - start_time))
    print('-'*40)


def user_stats(df):
    """Displays statistics on bikeshare users."""

    print('\nCalculating User Stats...\n')
    start_time = time.time()

    # Display counts of user types
    user_types = df['User Type'].value_counts()
    print("The types of users are:", user_types)

    # Display counts of gender
    try:
        gender = df['Gender'].value_counts()
        print("Gender breakdown is:", gender)
    except KeyError:
        print("No gender data for Washington")

    # Display earliest, most recent, and most common year of birth
    try:
        oldest = df['Birth Year'].min()
        print("The oldest birth year is:", oldest)
        youngest = df['Birth Year'].max()
        print("The youngest birth year is:", youngest)
        common_age = df['Birth Year'].mode()[0]
        print("The most common birth year is:", common_age)
    except KeyError:
        print("No birth year data for Washington")

    print("\nThis took %s seconds." % (time.time() - start_time))
    print('-'*40)


# Display more data
def more_data(df):
    load_more_data = input('\nWould you like to view 5 rows of individual trip data? Enter yes or no\n').lower()
    start_loc = 0
    while load_more_data == 'yes':
        print(df.iloc[0:5])
        start_loc += 5
        load_more_data = input("Would you like to view 5 rows of data? Enter yes or no: ").lower()

    return df


def main():
    while True:
        city, month, day = get_filters()
        df = load_data(city, month, day)

        time_stats(df)
        station_stats(df)
        trip_duration_stats(df)
        user_stats(df)
        more_data(df)

        restart = input('\nWould you like to restart? Enter yes or no.\n')
        if restart.lower() != 'yes':
            break


if __name__ == "__main__":
    main()
