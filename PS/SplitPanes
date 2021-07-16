#Quick way to open split panes of 2 profiles in Windows Terminal
#Profile is profile name - use quotes if spaces in name
#Type is V for vertical or H for horizontal
Function SplitPanes ($profile1, $profile2, $type)
{
    wt -p $profile1`; split-pane -p $profile2 `-$type
}
