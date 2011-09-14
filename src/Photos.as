/**
 * Created by JetBrains Flex IDE.
 * User: jetbrains
 * Date: 9/14/11
 * Time: 12:49 AM
 * To change this template use File | Settings | File Templates.
 */
package {
public class Photos {

    [Embed(source="/ipad_photos.zip", mimeType="application/octet-stream")]
    private static var photosZipResource:Class;

    public static function loadPhotos(handler:Function):void {
        new Loader(photosZipResource, handler);
    }

    [Embed(source="vabank.mp3")]
    public static var slideShowSound:Class;

    [Embed(source="fanfare2.mp3")]
    public static var fanfareSound:Class;
}
}

import deng.fzip.FZip;
import deng.fzip.FZipEvent;
import deng.fzip.FZipFile;

import flash.events.Event;

class Loader {

    private var _files:Vector.<FZipFile> = new Vector.<FZipFile>();
    private var _handler:Function;

    public function Loader(zipFileResource:Class, handler:Function) {
        _handler = handler;
        var photosFile:* = new zipFileResource();
        var zip:FZip = new FZip();
        zip.addEventListener(FZipEvent.FILE_LOADED, onFileLoaded);
        zip.addEventListener(Event.COMPLETE, onComplete);
        zip.loadBytes(photosFile);
    }

    private function onComplete(event:Event):void {
        _handler(_files);
    }

    private function onFileLoaded(event:FZipEvent):void {
        _files.push(event.file);
    }


}
