<?php
class StaticSiteValetDriver extends ValetDriver
{
    /**
     * Determine if the driver serves the request.
     *
     * @param  string  $sitePath
     * @param  string  $siteName
     * @param  string  $uri
     * @return bool
     */
    public function serves($sitePath, $siteName, $uri)
    {
        if (is_dir($sitePath . '/assets/dist') && is_file($sitePath.'/index.html')) {
            return true;
        }

        return false;
    }

    /**
     * Determine if the incoming request is for a static file.
     *
     * @param  string  $sitePath
     * @param  string  $siteName
     * @param  string  $uri
     * @return string|false
     */
    public function isStaticFile($sitePath, $siteName, $uri)
    {
        if (file_exists($staticFilePath = $sitePath . '/' . $uri . '/index.html')) {
            return $staticFilePath;
        }
        if (file_exists($staticFilePath = $sitePath . '/' . $uri . 'index.html')) {
            return $staticFilePath;
        }
        if (file_exists($staticFilePath = $sitePath . '/' . $uri . '.html')) {
            return $staticFilePath;
        }
        if (file_exists($staticFilePath = $sitePath . '/' . $uri)) {
            return $staticFilePath;
        }

        return $sitePath.'/404.html';
    }

    /**
     * Get the fully resolved path to the application's front controller.
     *
     * @param  string  $sitePath
     * @param  string  $siteName
     * @param  string  $uri
     * @return string
     */
    public function frontControllerPath($sitePath, $siteName, $uri)
    {
        return $sitePath . '/index.html';
    }
}
