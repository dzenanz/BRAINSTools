"""
bidsUtils_test.py
============================
Description:
    This file is used to test the bidsUtils formatter

Author:

Usage: N/A not a command line script (no bang above)

"""
# I don't know if pytest is a dependency of this project, so I am avoiding adding it for the moments

from bidsUtils import BAWBIDSFormatter

if __name__ == "__main__":
    try:
        subject_info = {
            "sub": "0123456",
            "ses": "43210",
            "space": "LPS",
            "run": "05",
            "favColor": "red",
            "spacing": "iso2mm",
        }
        bids_formatter = BAWBIDSFormatter()
        print(
            bids_formatter.get_bids_name(
                subject_data=subject_info,
                full_path="/Shared/sinapse/out/",
                ext="nii.gz",
            )
        )
        print("Success")
    except Exception as e:
        print("Failure")

    try:
        no_sub = {
            "ses": "43210",
            "space": "LPS",
            "run": "05",
            "favColor": "red",
            "spacing": "iso2mm",
        }
        bids_formatter = BAWBIDSFormatter()
        bids_formatter.get_bids_name(subject_data=no_sub)
        print("Failure")
    except KeyError as e:
        print("Success")

    try:
        no_ses = {
            "sub": "0123456",
            "space": "LPS",
            "run": "05",
            "favColor": "red",
            "spacing": "iso2mm",
        }
        bids_formatter = BAWBIDSFormatter()
        bids_formatter.get_bids_name(subject_data=no_ses)
        print("Failure")
    except KeyError as e:
        print("Success")
