"""
Defines logic for pulling from the database.
"""

import sys
import mysql.connector
from .database_controller import mysql_database_connection


def show_location_data():
    """Shows location data by using a SELECT statement"""
    try:
        database = mysql_database_connection()
    # pylint: disable=broad-except
    except BaseException:
        print("error connecting to the database. please verify that MySQL is running.")
        sys.exit()

    cursor = database.cursor(buffered=True)
    try:
        headers = []
        cursor.execute("SELECT * FROM location ;")
        result = cursor.fetchall()
        cursor.execute("SHOW COLUMNS FROM location ;")
        headers_list = cursor.fetchall()
        for row in headers_list:
            headers.append(row[0])
        return result, headers
    except mysql.connector.Error as err:
        print(f"Something went wrong pulling location data from database: {err}")
        return None


def show_sample_info():
    """Shows sample info by using a SELECT statement"""
    try:
        database = mysql_database_connection()
    # pylint: disable=broad-except
    except BaseException:
        print("error connecting to the database. please verify that MySQL is running.")
        sys.exit()

    cursor = database.cursor(buffered=True)
    try:
        headers = []
        cursor.execute("SELECT * FROM sample_data_view ;")
        result = cursor.fetchall()
        cursor.execute("SHOW COLUMNS FROM sample_data_view ;")
        headers_list = cursor.fetchall()
        for row in headers_list:
            headers.append(row[0])
        return result, headers
    except mysql.connector.Error as err:
        print(f"Something went wrong pulling sample info from database: {err}")
        return None


def show_submission_data():
    """Show Submission data by using a SELECT statement"""
    try:
        database = mysql_database_connection()
    # pylint: disable=broad-except
    except BaseException:
        print("error connecting to the database. please verify that MySQL is running.")
        sys.exit()

    cursor = database.cursor(buffered=True)
    try:
        headers = []
        cursor.execute("SELECT * FROM submission_data ;")
        result = cursor.fetchall()
        cursor.execute("SHOW COLUMNS FROM submission_data ;")
        headers_list = cursor.fetchall()
        for row in headers_list:
            headers.append(row[0])
        return result, headers
    except mysql.connector.Error as err:
        print(f"Something went wrong pulling submission data from database: {err}")
        return None


def show_sample_data():
    """Show sample data by using the SELECT statement"""
    try:
        database = mysql_database_connection()
    # pylint: disable=broad-except
    except BaseException:
        print("error connecting to the database. please verify that MySQL is running.")
        sys.exit()

    cursor = database.cursor(buffered=True)
    try:
        headers = []
        cursor.execute("SELECT * FROM sample_info ;")
        result = cursor.fetchall()
        cursor.execute("SHOW COLUMNS FROM sample_info ;")
        headers_list = cursor.fetchall()
        for row in headers_list:
            headers.append(row[0])
        return result, headers
    except mysql.connector.Error as err:
        print(f"Something went wrong pulling location data from database: {err}")
        return None

def get_abund_data(start_date, end_date, sample_type):
    """Show abundance plot visualization"""
    try:
        database = mysql_database_connection()
    # pylint: disable=broad-except
    except BaseException:
        print("error connecting to the database. please verify that MySQL is running.")
        sys.exit()

    cursor = database.cursor(buffered=True)
    try:
        sample_type_filter = f"AND sample_info.`Sample Type` = {sample_type}" if sample_type else ""
        min_abund = 0.01
        sample_id_filter = "'%'"

        query = (
            "WITH filtered_sample AS ("
                "SELECT a.`Sample ID`, a.`name`, a.taxonomy_id, a.fraction_total_reads "
                "FROM sample_data a "
                "JOIN ("
                    "SELECT `Sample ID`, `name`, taxonomy_id "
                    "FROM sample_data "
                    "GROUP BY `name` "
                    f"HAVING MAX(fraction_total_reads) > {min_abund}"
                ") b ON a.taxonomy_id = b.taxonomy_id "
                f"WHERE a.`Sample ID` LIKE {sample_id_filter}"
            "),"
            "sample_info_data AS ("
                "SELECT sample_info.`Sample ID` AS 'sample_ID', species.`name` AS 'genus', "
                    "filtered_sample.fraction_total_reads*100 AS 'value', "
                    f"DATE_FORMAT(sample_info.`Date Filtered`, '%b-%e-%y') AS 'date' "
                "FROM sample_info "
                "JOIN filtered_sample ON filtered_sample.`Sample ID` = sample_info.`Sample ID` "
                "JOIN species ON species.taxonomy_id = filtered_sample.taxonomy_id "
                f"WHERE sample_info.`Date Filtered` BETWEEN '{start_date}' AND '{end_date}' "
                f"{sample_type_filter}"
            ") "
            "SELECT sample_info_data.sample_ID, sample_info_data.genus, sample_info_data.`value`, "
            "sample_info_data.`date` "
            "FROM sample_info_data "
            "UNION "
            "SELECT sample_info_data.sample_ID, 'Unclassified_Bacteria' AS 'genus', "
            "100-SUM(sample_info_data.`value`) AS 'value', sample_info_data.`date` "
            "FROM sample_info_data "
            "GROUP BY sample_ID "
            "ORDER BY genus, sample_ID "
            ";"
        )
        cursor.execute(query)
        result = cursor.fetchall()
        return result
    except mysql.connector.Error as err:
        print(f"Something went wrong pulling abund data from database: {err}")
        return None
