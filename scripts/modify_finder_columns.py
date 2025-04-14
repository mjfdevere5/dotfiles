import plistlib
import os

plist_path = os.path.join(os.path.dirname(__file__), "finder_tmp.plist")  # working with exported plist

def modify_extended_list_view_columns(columns):
    """
    Handles columns inside ExtendedListViewSettingsV2.
    These are stored as a list of dictionaries.
    We do NOT add any new columns — just update existing ones.
    """
    modified_columns = []
    for col in columns:
        identifier = col.get('identifier') or col.get('name')
        new_col = dict(col)  # Copy to avoid mutating in-place
        if identifier == 'name':
            new_col['visible'] = True
            new_col['width'] = 463
        elif identifier == 'size':
            new_col['visible'] = True
            new_col['width'] = 97
        else:
            new_col['visible'] = False
        modified_columns.append(new_col)
    return modified_columns

def modify_list_view_columns(columns):
    """
    Handles columns inside ListViewSettings and FK_DefaultListViewSettings.
    These are stored as a dictionary of {identifier: column_dict}.
    Again, we only modify existing columns — no additions.
    """
    for identifier, col in columns.items():
        if identifier == 'name':
            col['visible'] = True
            col['width'] = 463
        elif identifier == 'size':
            col['visible'] = True
            col['width'] = 9
        else:
            col['visible'] = False
    return columns

def process_view_settings(view_settings):
    """
    Processes a given view settings block (StandardViewSettings or ComputerViewSettings).
    """
    if 'ExtendedListViewSettingsV2' in view_settings:
        ext_settings = view_settings['ExtendedListViewSettingsV2']
        if 'columns' in ext_settings:
            ext_settings['columns'] = modify_extended_list_view_columns(ext_settings['columns'])

    if 'ListViewSettings' in view_settings:
        list_settings = view_settings['ListViewSettings']
        if 'columns' in list_settings:
            list_settings['columns'] = modify_list_view_columns(list_settings['columns'])

def main():
    with open(plist_path, 'rb') as f:
        plist = plistlib.load(f)

    if 'FK_DefaultListViewSettings' in plist:
        if 'columns' in plist['FK_DefaultListViewSettings']:
            modify_extended_list_view_columns(plist['FK_DefaultListViewSettings']['columns'])

    if 'StandardViewSettings' in plist:
        process_view_settings(plist['StandardViewSettings'])

    if 'ComputerViewSettings' in plist:
        process_view_settings(plist['ComputerViewSettings'])

    with open(plist_path, 'wb') as f:
        plistlib.dump(plist, f)

    print(f"✅ Completed {os.path.basename(__file__)}.")

if __name__ == "__main__":
    main()