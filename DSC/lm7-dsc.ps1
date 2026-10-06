Configuration EmreBaseline
{
    Import-DscResource -ModuleName PSDesiredStateConfiguration

    Node localhost
    {
        WindowsFeature IISWebServer
        {
            Name   = "Web-Server"
            Ensure = "Present"
        }

        File BaselineFolder
        {
            DestinationPath = "C:\EmreBaseline"
            Type            = "Directory"
            Ensure          = "Present"
        }
    }
}