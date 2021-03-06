<?php
class JekyllValetDriver extends ValetDriver
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
        if (is_dir($sitePath . '/_site')) {
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
        if (file_exists($staticFilePath = $sitePath . '/_site/' . $uri . '/index.html')) {
            return $staticFilePath;
        }
        if (file_exists($staticFilePath = $sitePath . '/_site/' . $uri . 'index.html')) {
            return $staticFilePath;
        }
        if (file_exists($staticFilePath = $sitePath . '/_site/' . $uri . '.html')) {
            return $staticFilePath;
        }
        if (file_exists($staticFilePath = $sitePath . '/_site/' . $uri)) {
            return $staticFilePath;
        }

        if (file_exists($staticFilePath = $sitePath . '/_site/404/index.html')) {
            return $staticFilePath;
        }

        return $sitePath.'/_site/404.html';
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
        return $sitePath . '/_site/index.html';
    }
}
