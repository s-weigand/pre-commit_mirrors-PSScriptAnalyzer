# This docker file is based on this block post
# https://www.benjaminrancourt.ca/lint-powershell-scripts-with-psscriptanalyzer/

# https://hub.docker.com/_/microsoft-powershell and https://mcr.microsoft.com/v2/powershell/tags/list
FROM mcr.microsoft.com/powershell:7.5-alpine-3.20

# OCI labels for metadata
LABEL org.opencontainers.image.title="pre-commit mirror for PSScriptAnalyzer"
LABEL org.opencontainers.image.description="Docker image used by pre-commit hooks to lint and format PowerShell scripts with PSScriptAnalyzer."
LABEL org.opencontainers.image.version="${PS_ANALYZER_VERSION}"
LABEL org.opencontainers.image.url="https://github.com/s-weigand/pre-commit_mirrors-PSScriptAnalyzer"
LABEL org.opencontainers.image.documentation="https://github.com/s-weigand/pre-commit_mirrors-PSScriptAnalyzer/blob/main/README.md"
LABEL org.opencontainers.image.source="https://github.com/s-weigand/pre-commit_mirrors-PSScriptAnalyzer"

# Change the shell to use Powershell directly for our commands
# instead of englobing them with pwsh -Command "MY_COMMAND"
SHELL [ "pwsh", "-Command" ]

ARG PS_ANALYZER_VERSION

RUN \
    # Sets values for a registered module repository
    Set-PSRepository \
    -ErrorAction Stop           <# Action to take if a command fails #> \
    -InstallationPolicy Trusted <# Installation policy (Trusted, Untrusted) #> \
    -Name PSGallery             <# Name of the repository #> \
    -Verbose;                   <# Write verbose output #> \
    # Install PSScriptAnalyzer module (https://github.com/PowerShell/PSScriptAnalyzer/tags)
    Install-Module \
    -ErrorAction Stop \
    -Name PSScriptAnalyzer    <# Name of modules to install from the online gallery #> \
    -RequiredVersion ${PS_ANALYZER_VERSION}   <# Exact version of a single module to install #> \
    -Verbose;

# Switch back to the default Linux shell as we are using a Linux Docker image for now
SHELL [ "/bin/sh" , "-c" ]
